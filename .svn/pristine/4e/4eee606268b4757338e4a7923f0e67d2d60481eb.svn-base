package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.hwfs.cmn.defaults.DefaultDTO;

/**
 * Fax DTO
 * @ClassName FaxDTO.java
 * @Description FaxDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 2. 3.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 2. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class FaxDTO extends DefaultDTO {

	private int msgid; 			//Message ID
	private String userid; 		//팩스와이드에서 할당한 사용자 ID
	private String userpw;		//팩스와이드에서 할당한 사용자 비밀번호
	private String recipient; 	//팩스 수신자명
	private String faxno;		//수신자 팩스번호(숫자만가능)
	private String filename;	//팩스로 전송할 파일의 절대경로
	private String errcode;		//Default:QRDY(대기중)->QPND(전송중)->0000(성공) 나머지 Error
	private String instime;		//팩스에 등록된 시간(현재시간)
	private String rsvtime;		//발송 예약시간(예약이 아니면 현재시간)
	private String sendtime;	//팩스와이드로 전송한시간
	private String endtime;		//팩스가 완료된 시간
	private int chargeSeconds;	//전송하는데 걸린 시간(초 단위)
	private float charge;		//부과된 요금	
	private String cuser;		//생성자
	private String cdate;		//생성일
	private String uuser;		//수정자
	private String udate;		//수정일
	
	/**
	 * toString override
	 *
	 * @return
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString () {
		return ToStringBuilder.reflectionToString(this);
	}

	/**
	 * msgid 얻기
	 *
	 * @return the msgid
	 */
	public int getMsgid() {
		return msgid;
	}

	/**
	 * msgid 설정
	 *
	 * @param msgid the msgid to set
	 */
	public void setMsgid(int msgid) {
		this.msgid = msgid;
	}

	/**
	 * userid 얻기
	 *
	 * @return the userid
	 */
	public String getUserid() {
		return userid;
	}

	/**
	 * userid 설정
	 *
	 * @param userid the userid to set
	 */
	public void setUserid(String userid) {
		this.userid = userid;
	}

	/**
	 * userpw 얻기
	 *
	 * @return the userpw
	 */
	public String getUserpw() {
		return userpw;
	}

	/**
	 * userpw 설정
	 *
	 * @param userpw the userpw to set
	 */
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}

	/**
	 * recipient 얻기
	 *
	 * @return the recipient
	 */
	public String getRecipient() {
		return recipient;
	}

	/**
	 * recipient 설정
	 *
	 * @param recipient the recipient to set
	 */
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	/**
	 * faxno 얻기
	 *
	 * @return the faxno
	 */
	public String getFaxno() {
		return faxno;
	}

	/**
	 * faxno 설정
	 *
	 * @param faxno the faxno to set
	 */
	public void setFaxno(String faxno) {
		this.faxno = faxno;
	}

	/**
	 * filename 얻기
	 *
	 * @return the filename
	 */
	public String getFilename() {
		return filename;
	}

	/**
	 * filename 설정
	 *
	 * @param filename the filename to set
	 */
	public void setFilename(String filename) {
		this.filename = filename;
	}

	/**
	 * errcode 얻기
	 *
	 * @return the errcode
	 */
	public String getErrcode() {
		return errcode;
	}

	/**
	 * errcode 설정
	 *
	 * @param errcode the errcode to set
	 */
	public void setErrcode(String errcode) {
		this.errcode = errcode;
	}

	/**
	 * instime 얻기
	 *
	 * @return the instime
	 */
	public String getInstime() {
		return instime;
	}

	/**
	 * instime 설정
	 *
	 * @param instime the instime to set
	 */
	public void setInstime(String instime) {
		this.instime = instime;
	}

	/**
	 * rsvtime 얻기
	 *
	 * @return the rsvtime
	 */
	public String getRsvtime() {
		return rsvtime;
	}

	/**
	 * rsvtime 설정
	 *
	 * @param rsvtime the rsvtime to set
	 */
	public void setRsvtime(String rsvtime) {
		this.rsvtime = rsvtime;
	}

	/**
	 * sendtime 얻기
	 *
	 * @return the sendtime
	 */
	public String getSendtime() {
		return sendtime;
	}

	/**
	 * sendtime 설정
	 *
	 * @param sendtime the sendtime to set
	 */
	public void setSendtime(String sendtime) {
		this.sendtime = sendtime;
	}

	/**
	 * endtime 얻기
	 *
	 * @return the endtime
	 */
	public String getEndtime() {
		return endtime;
	}

	/**
	 * endtime 설정
	 *
	 * @param endtime the endtime to set
	 */
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	/**
	 * chargeSeconds 얻기
	 *
	 * @return the chargeSeconds
	 */
	public int getChargeSeconds() {
		return chargeSeconds;
	}

	/**
	 * chargeSeconds 설정
	 *
	 * @param chargeSeconds the chargeSeconds to set
	 */
	public void setChargeSeconds(int chargeSeconds) {
		this.chargeSeconds = chargeSeconds;
	}

	/**
	 * charge 얻기
	 *
	 * @return the charge
	 */
	public float getCharge() {
		return charge;
	}

	/**
	 * charge 설정
	 *
	 * @param charge the charge to set
	 */
	public void setCharge(float charge) {
		this.charge = charge;
	}

	/**
	 * cuser 얻기
	 *
	 * @return the cuser
	 */
	public String getCuser() {
		return cuser;
	}

	/**
	 * cuser 설정
	 *
	 * @param cuser the cuser to set
	 */
	public void setCuser(String cuser) {
		this.cuser = cuser;
	}

	/**
	 * cdate 얻기
	 *
	 * @return the cdate
	 */
	public String getCdate() {
		return cdate;
	}

	/**
	 * cdate 설정
	 *
	 * @param cdate the cdate to set
	 */
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}

	/**
	 * uuser 얻기
	 *
	 * @return the uuser
	 */
	public String getUuser() {
		return uuser;
	}

	/**
	 * uuser 설정
	 *
	 * @param uuser the uuser to set
	 */
	public void setUuser(String uuser) {
		this.uuser = uuser;
	}

	/**
	 * udate 얻기
	 *
	 * @return the udate
	 */
	public String getUdate() {
		return udate;
	}

	/**
	 * udate 설정
	 *
	 * @param udate the udate to set
	 */
	public void setUdate(String udate) {
		this.udate = udate;
	}

	
}
