package com.sp.chat;

import org.springframework.web.socket.WebSocketSession;

public class User {
	private String nickName;
	private WebSocketSession session;

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public WebSocketSession getSession() {
		return session;
	}

	public void setSession(WebSocketSession session) {
		this.session = session;
	}

}
