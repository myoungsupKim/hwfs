package com.hwfs.sc.cmn.sap.dto;

import java.io.Serializable;

import com.hwfs.cmn.defaults.DefaultDTO;

 /**
 * ElctnTaxShetPublishDTO에 대한 설명 작성
 * @ClassName ElctnTaxShetPublishDTO.java
 * @Description ElctnTaxShetPublishDTO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 18.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 6. 18.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class ElctnTaxShetPublishDTO extends DefaultDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String taxShetNum = "";
	private String publishSabun1 = "";
	private String publishName1 = "";
	private String publishTel1 = "";
	private String publishHp1 = "";
	private String publishEmail1 = "";
	private String publishSabun2 = "";
	private String publishName2 = "";
	private String publishTel2 = "";
	private String publishHp2 = "";
	private String publishEmail2 = "";
	private String procUserSabun = "";
	private String picode = "";
	private String pistat = "R";
	private String pidate = "";
	private String pitime = "";
	private String piuser = "";
	private String pimsg = "";
	private String pimsgid = "";

	/**
	 * picode 얻기
	 *
	 * @return the picode
	 */
	public String getPicode() {
		return picode;
	}
	/**
	 * picode 설정
	 *
	 * @param picode the picode to set
	 */
	public void setPicode(String picode) {
		this.picode = picode;
	}
	/**
	 * pistat 얻기
	 *
	 * @return the pistat
	 */
	public String getPistat() {
		return pistat;
	}
	/**
	 * pistat 설정
	 *
	 * @param pistat the pistat to set
	 */
	public void setPistat(String pistat) {
		this.pistat = pistat;
	}
	/**
	 * pidate 얻기
	 *
	 * @return the pidate
	 */
	public String getPidate() {
		return pidate;
	}
	/**
	 * pidate 설정
	 *
	 * @param pidate the pidate to set
	 */
	public void setPidate(String pidate) {
		this.pidate = pidate;
	}
	/**
	 * pitime 얻기
	 *
	 * @return the pitime
	 */
	public String getPitime() {
		return pitime;
	}
	/**
	 * pitime 설정
	 *
	 * @param pitime the pitime to set
	 */
	public void setPitime(String pitime) {
		this.pitime = pitime;
	}
	/**
	 * piuser 얻기
	 *
	 * @return the piuser
	 */
	public String getPiuser() {
		return piuser;
	}
	/**
	 * piuser 설정
	 *
	 * @param piuser the piuser to set
	 */
	public void setPiuser(String piuser) {
		this.piuser = piuser;
	}
	/**
	 * pimsg 얻기
	 *
	 * @return the pimsg
	 */
	public String getPimsg() {
		return pimsg;
	}
	/**
	 * pimsg 설정
	 *
	 * @param pimsg the pimsg to set
	 */
	public void setPimsg(String pimsg) {
		this.pimsg = pimsg;
	}
	/**
	 * pimsgid 얻기
	 *
	 * @return the pimsgid
	 */
	public String getPimsgid() {
		return pimsgid;
	}
	/**
	 * pimsgid 설정
	 *
	 * @param pimsgid the pimsgid to set
	 */
	public void setPimsgid(String pimsgid) {
		this.pimsgid = pimsgid;
	}
	/**
	 * publishSabun1 얻기
	 *
	 * @return the publishSabun1
	 */
	public String getPublishSabun1() {
		return publishSabun1;
	}
	/**
	 * publishSabun1 설정
	 *
	 * @param publishSabun1 the publishSabun1 to set
	 */
	public void setPublishSabun1(String publishSabun1) {
		this.publishSabun1 = publishSabun1;
	}
	/**
	 * publishName1 얻기
	 *
	 * @return the publishName1
	 */
	public String getPublishName1() {
		return publishName1;
	}
	/**
	 * publishName1 설정
	 *
	 * @param publishName1 the publishName1 to set
	 */
	public void setPublishName1(String publishName1) {
		this.publishName1 = publishName1;
	}
	/**
	 * publishTel1 얻기
	 *
	 * @return the publishTel1
	 */
	public String getPublishTel1() {
		return publishTel1;
	}
	/**
	 * publishTel1 설정
	 *
	 * @param publishTel1 the publishTel1 to set
	 */
	public void setPublishTel1(String publishTel1) {
		this.publishTel1 = publishTel1;
	}
	/**
	 * publishHp1 얻기
	 *
	 * @return the publishHp1
	 */
	public String getPublishHp1() {
		return publishHp1;
	}
	/**
	 * publishHp1 설정
	 *
	 * @param publishHp1 the publishHp1 to set
	 */
	public void setPublishHp1(String publishHp1) {
		this.publishHp1 = publishHp1;
	}
	/**
	 * publishEmail1 얻기
	 *
	 * @return the publishEmail1
	 */
	public String getPublishEmail1() {
		return publishEmail1;
	}
	/**
	 * publishEmail1 설정
	 *
	 * @param publishEmail1 the publishEmail1 to set
	 */
	public void setPublishEmail1(String publishEmail1) {
		this.publishEmail1 = publishEmail1;
	}
	/**
	 * publishSabun2 얻기
	 *
	 * @return the publishSabun2
	 */
	public String getPublishSabun2() {
		return publishSabun2;
	}
	/**
	 * publishSabun2 설정
	 *
	 * @param publishSabun2 the publishSabun2 to set
	 */
	public void setPublishSabun2(String publishSabun2) {
		this.publishSabun2 = publishSabun2;
	}
	/**
	 * publishName2 얻기
	 *
	 * @return the publishName2
	 */
	public String getPublishName2() {
		return publishName2;
	}
	/**
	 * publishName2 설정
	 *
	 * @param publishName2 the publishName2 to set
	 */
	public void setPublishName2(String publishName2) {
		this.publishName2 = publishName2;
	}
	/**
	 * publishTel2 얻기
	 *
	 * @return the publishTel2
	 */
	public String getPublishTel2() {
		return publishTel2;
	}
	/**
	 * publishTel2 설정
	 *
	 * @param publishTel2 the publishTel2 to set
	 */
	public void setPublishTel2(String publishTel2) {
		this.publishTel2 = publishTel2;
	}
	/**
	 * publishHp2 얻기
	 *
	 * @return the publishHp2
	 */
	public String getPublishHp2() {
		return publishHp2;
	}
	/**
	 * publishHp2 설정
	 *
	 * @param publishHp2 the publishHp2 to set
	 */
	public void setPublishHp2(String publishHp2) {
		this.publishHp2 = publishHp2;
	}
	/**
	 * publishEmail2 얻기
	 *
	 * @return the publishEmail2
	 */
	public String getPublishEmail2() {
		return publishEmail2;
	}
	/**
	 * publishEmail2 설정
	 *
	 * @param publishEmail2 the publishEmail2 to set
	 */
	public void setPublishEmail2(String publishEmail2) {
		this.publishEmail2 = publishEmail2;
	}
	/**
	 * procUserSabun 얻기
	 *
	 * @return the procUserSabun
	 */
	public String getProcUserSabun() {
		return procUserSabun;
	}
	/**
	 * procUserSabun 설정
	 *
	 * @param procUserSabun the procUserSabun to set
	 */
	public void setProcUserSabun(String procUserSabun) {
		this.procUserSabun = procUserSabun;
	}
	/**
	 * taxShetNum 얻기
	 *
	 * @return the taxShetNum
	 */
	public String getTaxShetNum() {
		return taxShetNum;
	}
	/**
	 * taxShetNum 설정
	 *
	 * @param taxShetNum the taxShetNum to set
	 */
	public void setTaxShetNum(String taxShetNum) {
		this.taxShetNum = taxShetNum;
	}

}
