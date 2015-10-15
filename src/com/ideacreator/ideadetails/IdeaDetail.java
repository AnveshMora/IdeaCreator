package com.ideacreator.ideadetails;

public class IdeaDetail {
	private int idea_Id;
	private String title;
	private String descritpion;
	private int upVote;
	private String idea_state;
	private int idea_state_id;
	private int postedUserId;
	public int getIdea_state_id() {
		return idea_state_id;
	}
	/**
	 * @return the postedUserId
	 */
	public int getPostedUserId() {
		return postedUserId;
	}
	/**
	 * @param postedUserId the postedUserId to set
	 */
	public void setPostedUserId(int postedUserId) {
		this.postedUserId = postedUserId;
	}
	public void setIdea_state_id(int idea_state_id) {
		this.idea_state_id = idea_state_id;
	}
	private String postedOn;
	private int commentsCount;
	public int getCommentsCount() {
		return commentsCount;
	}
	public void setCommentsCount(int commentsCount) {
		this.commentsCount = commentsCount;
	}
	public int getIdea_Id() {
		return idea_Id;
	}
	public void setIdea_Id(int idea_Id) {
		this.idea_Id = idea_Id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescritpion() {
		return descritpion;
	}
	public void setDescritpion(String descritpion) {
		this.descritpion = descritpion;
	}
	public int getUpVote() {
		return upVote;
	}
	public void setUpVote(int upVote) {
		this.upVote = upVote;
	}
	public String getIdea_state() {
		return idea_state;
	}
	public void setIdea_state(String idea_state) {
		this.idea_state = idea_state;
	}
	public String getPostedOn() {
		return postedOn;
	}
	public void setPostedOn(String postedOn) {
		this.postedOn = postedOn;
	}
}
