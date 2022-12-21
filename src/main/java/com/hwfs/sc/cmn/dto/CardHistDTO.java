package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

/**
 * 신용카드 정보 VAN사와 인터페이스 이력 정보를 담고 있는 DTO
 * 
 * @ClassName CardHistDTO.java
 * @Description CardHistDTO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 07. 06   ChAoS        최초생성
 * </pre>
 * @author 통합영업회계(ISA) : ChAoS
 * @since 2015. 07. 06
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2015 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class CardHistDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String compCd; 			/* 회사 코드 */
	private String sysTypeCd; 		/* 시스템 구분 코드 */
	private String brchCd; 			/* 사업장 코드 */
	private String recdType;		/* 전문코드(C01 거래내역,C02 청구,C03 입반송) */
	private String recptDt;			/* 처리일자(YYYYMMDD) */
	private String sendRecType;		/* 송수신구분 (S:전송, R:수신) */
	private String cnt;				/* 건수 */
	private String fileNm;			/* 파일명 */
	private String errYn;			/* 오류여부 (기본 N) */
	private String prcDt;			/* 처리일시 */
	private String description;		/* 비고 메시지 */
	private String recdStat;		/* 레코드 상태 */
	private String cratId;			/* 등록자 */
	private String updtId;			/* 수정자 */
	
	/**
	 * compCd 얻기
	 *
	 * @return the compCd
	 */
	public String getCompCd() {
		return compCd;
	}
	
	/**
	 * compCd 설정
	 *
	 * @param compCd the compCd to set
	 */
	public void setCompCd(String compCd) {
		this.compCd = compCd;
	}
	
	/**
	 * sysTypeCd 얻기
	 *
	 * @return the sysTypeCd
	 */
	public String getSysTypeCd() {
		return sysTypeCd;
	}
	
	/**
	 * sysTypeCd 설정
	 *
	 * @param sysTypeCd the sysTypeCd to set
	 */
	public void setSysTypeCd(String sysTypeCd) {
		this.sysTypeCd = sysTypeCd;
	}
	
	/**
	 * brchCd 얻기
	 *
	 * @return the brchCd
	 */
	public String getBrchCd() {
		return brchCd;
	}
	
	/**
	 * brchCd 설정
	 *
	 * @param brchCd the brchCd to set
	 */
	public void setBrchCd(String brchCd) {
		this.brchCd = brchCd;
	}
	
	/**
	 * recdType 얻기
	 *
	 * @return the recdType
	 */
	public String getRecdType() {
		return recdType;
	}
	
	/**
	 * recdType 설정
	 *
	 * @param recdType the recdType to set
	 */
	public void setRecdType(String recdType) {
		this.recdType = recdType;
	}
	
	/**
	 * recptDt 얻기
	 *
	 * @return the recptDt
	 */
	public String getRecptDt() {
		return recptDt;
	}
	
	/**
	 * recptDt 설정
	 *
	 * @param recptDt the recptDt to set
	 */
	public void setRecptDt(String recptDt) {
		this.recptDt = recptDt;
	}
	
	/**
	 * sendRecType 얻기
	 *
	 * @return the sendRecType
	 */
	public String getSendRecType() {
		return sendRecType;
	}
	
	/**
	 * sendRecType 설정
	 *
	 * @param sendRecType the sendRecType to set
	 */
	public void setSendRecType(String sendRecType) {
		this.sendRecType = sendRecType;
	}
	
	/**
	 * cnt 얻기
	 *
	 * @return the cnt
	 */
	public String getCnt() {
		return cnt;
	}
	
	/**
	 * cnt 설정
	 *
	 * @param cnt the cnt to set
	 */
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	
	/**
	 * fileNm 얻기
	 *
	 * @return the fileNm
	 */
	public String getFileNm() {
		return fileNm;
	}
	
	/**
	 * fileNm 설정
	 *
	 * @param fileNm the fileNm to set
	 */
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	
	/**
	 * errYn 얻기
	 *
	 * @return the errYn
	 */
	public String getErrYn() {
		return errYn;
	}
	
	/**
	 * errYn 설정
	 *
	 * @param errYn the errYn to set
	 */
	public void setErrYn(String errYn) {
		this.errYn = errYn;
	}
	
	/**
	 * prcDt 얻기
	 *
	 * @return the prcDt
	 */
	public String getPrcDt() {
		return prcDt;
	}
	
	/**
	 * prcDt 설정
	 *
	 * @param prcDt the prcDt to set
	 */
	public void setPrcDt(String prcDt) {
		this.prcDt = prcDt;
	}
	
	/**
	 * description 얻기
	 *
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	
	/**
	 * description 설정
	 *
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	
	/**
	 * recdStat 얻기
	 *
	 * @return the recdStat
	 */
	public String getRecdStat() {
		return recdStat;
	}
	
	/**
	 * recdStat 설정
	 *
	 * @param recdStat the recdStat to set
	 */
	public void setRecdStat(String recdStat) {
		this.recdStat = recdStat;
	}
	
	/**
	 * cratId 얻기
	 *
	 * @return the cratId
	 */
	public String getCratId() {
		return cratId;
	}
	
	/**
	 * cratId 설정
	 *
	 * @param cratId the cratId to set
	 */
	public void setCratId(String cratId) {
		this.cratId = cratId;
	}
	
	/**
	 * updtId 얻기
	 *
	 * @return the updtId
	 */
	public String getUpdtId() {
		return updtId;
	}
	
	/**
	 * updtId 설정
	 *
	 * @param updtId the updtId to set
	 */
	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}
	
}