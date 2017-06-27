package com.sp.chat;

import java.util.Calendar;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class MySocketHandler extends TextWebSocketHandler {
	private final Logger logger = LoggerFactory.getLogger(getClass());

	private Map<String, User> mapSession = new Hashtable<>();

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		// 웹소켓 연결이 닫혔을 때 호출
		removeUser(session);
		logger.info("remove session id : " + session.getId());
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		// 웹소켓이 연결되고 사용이 준비 될 때 호출
		logger.info("add session id : " + session.getId() + ", ip :" + session.getRemoteAddress().getHostName());
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		// 클라이언트로부터 메시지가 도착했을 때 호출

		/* logger.info("message : " + message.getPayload()); */
		JSONObject jsonReceive = (JSONObject) JSONSerializer.toJSON(message.getPayload());
		String cmd = jsonReceive.getString("cmd");

		if (cmd.equals("conn")) {
			String uid = jsonReceive.getString("userId");
			String nickName = jsonReceive.getString("nickName");

			User user = new User();
			user.setNickName(nickName);
			user.setSession(session);
			mapSession.put(uid, user);

			// 현재 접속중인 사람을 접속자에게 전송
			Iterator<String> it = mapSession.keySet().iterator();
			while (it.hasNext()) {
				String key = it.next();
				if (key.equals(uid))
					continue;

				User u = mapSession.get(key);
				JSONObject job = new JSONObject();
				job.put("cmd", "connect-list");
				job.put("userId", key);
				job.put("nickName", u.getNickName());
				sendOneMessage(job.toString(), session);
			}

			// 모든 클라이언트에게 접속 사실을 알린다.
			JSONObject job = new JSONObject();
			job.put("cmd", "connect-list");
			job.put("userId", uid);
			job.put("nickName", nickName);

			sendAllMessage(job.toString(), uid);

		} else if (cmd.equals("message")) {
			String guestId = getUserId(session);
			if (guestId == null)
				return;
			String nickName = mapSession.get(guestId).getNickName();
			String msg = jsonReceive.getString("message");

			// 모든 클라이언트에게 접속 사실을 알린다.
			JSONObject job = new JSONObject();
			job.put("cmd", "message");
			job.put("userId", guestId);
			job.put("nickName", nickName);
			job.put("message", msg);

			sendAllMessage(job.toString(), guestId);

		}
	}

	@Override
	public boolean supportsPartialMessages() {
		// SocketHandler가 부분 메시지를 처리할때 호출
		return super.supportsPartialMessages();
	}

	public void sendAllMessage(String message, String out) {
		Iterator<String> it = mapSession.keySet().iterator();
		while (it.hasNext()) {
			String uid = it.next();
			User user = mapSession.get(uid);

			if (out != null && uid.equals(out)) // 자기 자신
				continue;

			if (user.getSession().isOpen()) {
				try {
					user.getSession().sendMessage(new TextMessage(message));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public void sendOneMessage(String message, WebSocketSession session) {
		if (session.isOpen()) {
			try {
				session.sendMessage(new TextMessage(message));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private String getUserId(WebSocketSession session) {
		String id = null;

		Iterator<String> it = mapSession.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			User user = mapSession.get(key);
			if (user.getSession() == session) {
				id = key;
				break;
			}
		}
		return id;
	}

	private void removeUser(WebSocketSession session) {
		try {
			String id = getUserId(session);
			User user = mapSession.get(id);

			if (user != null) {
				JSONObject job = new JSONObject();
				job.put("cmd", "disconn");
				job.put("guestId", id);
				job.put("nickName", user.getNickName());
				sendAllMessage(job.toString(), id);
				
				try {
					user.getSession().close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			mapSession.remove(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void init() throws Exception {
		Thread t = new Thread() {
			@Override
			public void run() {
				while (true) {
					try {
						Calendar cal = Calendar.getInstance();
						int hour = cal.get(Calendar.HOUR);
						int minute = cal.get(Calendar.MINUTE);
						int second = cal.get(Calendar.SECOND);
						
						JSONObject job = new JSONObject();
						job.put("cmd", "time");
						job.put("hour", hour);
						job.put("minute", minute);
						job.put("second", second);
						
						sendAllMessage(job.toString(), null);
						
						Thread.sleep(1000*3);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		};
		t.start();
	}
}
