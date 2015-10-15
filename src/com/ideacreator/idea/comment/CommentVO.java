package com.ideacreator.idea.comment;

import java.util.Date;

public class CommentVO {
	public String commentDesc;
	public int commentId;
	public int ideaId;
	public Date commentedOn;
	public String commentedBy;
	/**
	 * @return the commentDesc
	 */
	public String getCommentDesc() {
		return commentDesc;
	}
	/**
	 * @param commentDesc the commentDesc to set
	 */
	public void setCommentDesc(String commentDesc) {
		this.commentDesc = commentDesc;
	}
	/**
	 * @return the commentId
	 */
	public int getCommentId() {
		return commentId;
	}
	/**
	 * @param commentId the commentId to set
	 */
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	/**
	 * @return the ideaId
	 */
	public int getIdeaId() {
		return ideaId;
	}
	/**
	 * @param ideaId the ideaId to set
	 */
	public void setIdeaId(int ideaId) {
		this.ideaId = ideaId;
	}
	/**
	 * @return the commentedOn
	 */
	public Date getCommentedOn() {
		return commentedOn;
	}
	/**
	 * @param commentedOn the commentedOn to set
	 */
	public void setCommentedOn(Date commentedOn) {
		this.commentedOn = commentedOn;
	}
	/**
	 * @return the commentedBy
	 */
	public String getCommentedBy() {
		return commentedBy;
	}
	/**
	 * @param commentedBy the commentedBy to set
	 */
	public void setCommentedBy(String commentedBy) {
		this.commentedBy = commentedBy;
	}
}
