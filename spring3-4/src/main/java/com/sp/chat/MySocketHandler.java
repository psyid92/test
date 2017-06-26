package com.sp.chat;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class MySocketHandler extends TextWebSocketHandler {
	private final Logger logger = LogManager.getLogger(getClass());
	
	private Map<String, User> sessionMap = new Hashtable<>();

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		super.afterConnectionClosed(session, status);
		
		// WebSocket 연결이 닫혔을 때 호출
		removeUser(session);
		
		this.logger.info("remove session!");
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		// WebSocket 연결이 열리고 사용이 준비될 때 호출
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		super.handleMessage(session, message);
		
		// 클라이언트로부터 메시지가 도착했을 때 호출
		
		JSONObject jsonReceive = (JSONObject) JSONSerializer.toJSON(message.getPayload());
		String cmd=jsonReceive.getString("cmd");
		if(cmd==null) return;
		
		if(cmd.equals("connect")) { // 처음 접속한 경우
			// 접속한 사용자의 아이디를 키로 Session과 정보를 저장
			String userId = jsonReceive.getString("userId");
			String nickName = jsonReceive.getString("nickName");
			
			User user=new User();
			user.setUserId(userId);
			user.setNickName(nickName);
			user.setSession(session);
			
			sessionMap.put(userId, user);
			
			// 현재 접속 중인 사용자를 전송 해줌
			Iterator<String> it = sessionMap.keySet().iterator();
			while (it.hasNext()) {
					String key = it.next();
					if(userId.equals(key))  // 자기 자신
						continue;
					
					User vo=sessionMap.get(key);
					
					JSONObject ob=new JSONObject();
					ob.put("cmd", "connectList");
					ob.put("userId", vo.getUserId());
					ob.put("nickName", vo.getNickName());
					
					sendOneMessage(ob.toString(), session);
			}
			
			// 다른 클라이언트에게 접속 사실을 알림
			JSONObject ob=new JSONObject();
			ob.put("cmd", "connect");
			ob.put("userId", userId);
			ob.put("nickName", nickName);
			sendAllMessage(ob.toString(),  userId);
			
		} else if(cmd.equals("message")) { // 채팅 문자열을 전송 한 경우
			User vo=getUser(session);
			String msg = jsonReceive.getString("chatMsg");
			
			JSONObject ob=new JSONObject();
			ob.put("cmd", "message");
			ob.put("chatMsg", msg);
			ob.put("userId", vo.getUserId());
			ob.put("nickName", vo.getNickName());
			
			// 다른 사용자에게 전송하기
			sendAllMessage(ob.toString(),  vo.getUserId());
		}
	}

	/*
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg=message.getPayload();
	}
	*/
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// this.logger.error("web socket error!", exception);
		removeUser(session);
	}

	// 모든 사용자에게 전송
	protected void sendAllMessage(String message, String out) {
		Iterator<String> it = sessionMap.keySet().iterator();
		while (it.hasNext()) {
			String key=it.next();
			if(out!=null && out.equals(key))  // 자기 자신
				continue;
			
			User user=sessionMap.get(key);
			WebSocketSession session=user.getSession();
			
			try {
				if (session.isOpen()) {
					session.sendMessage(new TextMessage(message));
				}
			} catch (IOException e) {
				removeUser(session);
			}			
		}
	}
	
	// 특정 사용자에게 전송
	protected void sendOneMessage(String message, WebSocketSession session) {
		if (session.isOpen()) {
			try {
				session.sendMessage(new TextMessage(message));
			} catch (Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
	}

	protected User getUser(WebSocketSession session) {
		User dto=null;
		Iterator<String> it =  sessionMap.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			
			User u=sessionMap.get(key);
			if(u.getSession()==session) {
				dto=u;
				break;
			}
		}
		return dto;
	}
	
	protected void removeUser(WebSocketSession session) {
		User user=getUser(session);
		
		if(user!=null) {
			JSONObject job=new JSONObject();
			job.put("cmd", "disconnect");
			job.put("userId", user.getUserId());
			job.put("nickName", user.getNickName());			
			sendAllMessage(job.toString(), user.getUserId());
			
			try {
				user.getSession().close();
			} catch (Exception e) {
			}
			sessionMap.remove(user.getUserId());
		}
	}
	
}
