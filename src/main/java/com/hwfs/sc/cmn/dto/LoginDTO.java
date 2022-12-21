package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * Login 정보를 담고 있는 DTO
 * @ClassName LoginDTO.java
 * @Description LoginDTO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 11. 20.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 11. 20.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class LoginDTO implements Serializable {

    private static final long serialVersionUID = 1L;

	private String userid = "";				/* 사용자ID(신규) */
	private String sabun = "";				/* 사번 */
	private String nmKor = "";				/* 이름 */
	private String ctiUseYn = "";			/* CTI 사용 여부(신규) */
	private String ctiUserId = "";			/* CTI 사용자 ID(신규) */
	private String accessIp = "";			/* 사용자 접근IP(신규) */
	private String persInfoAgreeYn = "";	/* 개인정보취급 동의(신규) */
	private String persInfoProcLevel = "";	/* 개인정보처리레벨 */
	private String persInfoProcGrade = "";	/* 개인정보처리등급 */
	private String persInfoMask = "";		/* 개인정보 항목별 마스크 여부 */

	/** 비밀번호오류 검사를 위한 멤버 */
	private String validPwdYn = "";			/* 비밀번호일치여부 */
	private int    pwdErrCnt = 0;			/* 비밀번호오류횟수 */
	private String pwdChgYn = "";			/* 비밀번호를 변경해야 하는지 여부 */
	private String pwdChgDate = "";			/* 비밀번호 변경일자 */
	private int    maxPwdErrCnt = 5;		/* 비밀번호오류 최대횟수 */
	private int    resultCode = 0;			/* 로그인 처리 결과 0 : 정상, < 0 : 오류 */

	/** 계정상태 */
	private String acctStatus = "";			/* 계정 상태 */
	private String acctLkReasonCd = "";		/* 계정잠김사유 코드 */

	private String authLevel = "";			/* 대표 권한 레벨 */
	private String authLevels = ""; 		/* 사용자 복수 권한레벨을 콤마(,)로 구분하여 반환한다. */
	private String manageAllowIp = "";		/* 관리자 접근 가능 IP 목록 */
	private String ccCd = "";
	private String ccNm = "";
	private String custCd = "";
	private String custNm = "";
	private String deptId = "";
	private String deptNm = "";
	private String mainUpjang = "";
	private String mainUpjangNm = "";
	private String muCd = "";
	private String muNm = "";
	private String otCustCd = "";
	private String otCustNm = "";
	private String scCd = "";
	private String scNm = "";
	private String tmCd = "";
	private String tmNm = "";
	private String ptCd = "";
	private String ptNm = "";
	private String upjang = "";
	private String upjangGroup = "";
	private String upjangNm = "";
	private String userGroup = "";
	private String userKind = "";
	private String simplePoYn = "";
	private String userType = "";
	private String systemMst = "";
	private String boardMst = "";
	private String tempSabunManageSabun = "";	/* 임시사번 관리사번 */
	private String hpNo ="";
	private String emailAddr = "";

	/** 중복로그인 관련 항목 */
	private String alreadyLoginYn = "";		/* 이미 로그인했는지 여부 */
	private String alreadyLoginDate = "";	/* 이미 로그인한 시간 */
	private String alreadyConnIp = "";		/* 이미 접속한 IP */

	/** 무단사용자 점검 항목 */
	private String itctYn = "";				/* 무단사용자 접속차단 여부 */

	/** 사용가능일 점검 항목 */
	private String useDateYn = "";			/* 사용가능일 여부 */
	private String useDate = "";			/* 사용가능일 From ~ To */

	private String introPage = ""; 			/* 초기 화면 */

	private String mainUpjangImg = "";      /* 메인 업장에 대한 이미지(CI) */
	
	private String sysTypeCnt = "0";        /* 사용 가능한 시스템 갯수(갯수가 1인 경우에는 시스템변경 아이콘을 숨긴다.) */
	private String upjangCnt = "1";         /* 사용 가능한 업장의 갯수(갯수가 1인 경우에는 업장변경 아이콘을 숨긴다.) */
	
	private String userRoles = "";          /* 사용자에게 부여된 권한 ROLE의 집합(,로 구분됨) */
	
	private String applyAuthYn = "";        /* 권한의 적용여부를 체크한다. */
	
	private String slipSabun = "";          /* 전표처리를 위한 실제사번(가사번인 경우에는 가사번 관리자의 사번을 그 외는 그냥 그 사번을 */

	private String gntCd = "";			/* 오늘 근태코드 */	
	private String gntNm = "";			/* 오늘 근태명 */
	private String nGntCd = "";		/* 내일 근태코드 */	
	private String nGntNm = "";			/* 내일 근태명 ~ To */
	private String gntYn = "";			/* 누무수령 거부확인여부 */
	
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
	 * sabun 얻기
	 *
	 * @return the sabun
	 */
	public String getSabun() {
		return sabun;
	}

	/**
	 * sabun 설정
	 *
	 * @param sabun the sabun to set
	 */
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}

	/**
	 * nmKor 얻기
	 *
	 * @return the nmKor
	 */
	public String getNmKor() {
		return nmKor;
	}

	/**
	 * nmKor 설정
	 *
	 * @param nmKor the nmKor to set
	 */
	public void setNmKor(String nmKor) {
		this.nmKor = nmKor;
	}

	/**
	 * ctiUseYn 얻기
	 *
	 * @return the ctiUseYn
	 */
	public String getCtiUseYn() {
		return ctiUseYn;
	}

	/**
	 * ctiUseYn 설정
	 *
	 * @param ctiUseYn the ctiUseYn to set
	 */
	public void setCtiUseYn(String ctiUseYn) {
		this.ctiUseYn = ctiUseYn;
	}

	/**
	 * ctiUserId 얻기
	 *
	 * @return the ctiUserId
	 */
	public String getCtiUserId() {
		return ctiUserId;
	}

	/**
	 * ctiUserId 설정
	 *
	 * @param ctiUserId the ctiUserId to set
	 */
	public void setCtiUserId(String ctiUserId) {
		this.ctiUserId = ctiUserId;
	}

	/**
	 * accessIp 얻기
	 *
	 * @return the accessIp
	 */
	public String getAccessIp() {
		return accessIp;
	}

	/**
	 * accessIp 설정
	 *
	 * @param accessIp the accessIp to set
	 */
	public void setAccessIp(String accessIp) {
		this.accessIp = accessIp;
	}

	/**
	 * authLevel 얻기
	 *
	 * @return the authLevel
	 */
	public String getAuthLevel() {
		return authLevel;
	}

	/**
	 * authLevel 설정
	 *
	 * @param authLevel the authLevel to set
	 */
	public void setAuthLevel(String authLevel) {
		this.authLevel = authLevel;
	}

	/**
	 * ccCd 얻기
	 *
	 * @return the ccCd
	 */
	public String getCcCd() {
		return ccCd;
	}

	/**
	 * ccCd 설정
	 *
	 * @param ccCd the ccCd to set
	 */
	public void setCcCd(String ccCd) {
		this.ccCd = ccCd;
	}

	/**
	 * ccNm 얻기
	 *
	 * @return the ccNm
	 */
	public String getCcNm() {
		return ccNm;
	}

	/**
	 * ccNm 설정
	 *
	 * @param ccNm the ccNm to set
	 */
	public void setCcNm(String ccNm) {
		this.ccNm = ccNm;
	}

	/**
	 * custCd 얻기
	 *
	 * @return the custCd
	 */
	public String getCustCd() {
		return custCd;
	}

	/**
	 * custCd 설정
	 *
	 * @param custCd the custCd to set
	 */
	public void setCustCd(String custCd) {
		this.custCd = custCd;
	}

	/**
	 * custNm 얻기
	 *
	 * @return the custNm
	 */
	public String getCustNm() {
		return custNm;
	}

	/**
	 * custNm 설정
	 *
	 * @param custNm the custNm to set
	 */
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}

	/**
	 * deptId 얻기
	 *
	 * @return the deptId
	 */
	public String getDeptId() {
		return deptId;
	}

	/**
	 * deptId 설정
	 *
	 * @param deptId the deptId to set
	 */
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	/**
	 * deptNm 얻기
	 *
	 * @return the deptNm
	 */
	public String getDeptNm() {
		return deptNm;
	}

	/**
	 * deptNm 설정
	 *
	 * @param deptNm the deptNm to set
	 */
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	/**
	 * mainUpjang 얻기
	 *
	 * @return the mainUpjang
	 */
	public String getMainUpjang() {
		return mainUpjang;
	}

	/**
	 * mainUpjang 설정
	 *
	 * @param mainUpjang the mainUpjang to set
	 */
	public void setMainUpjang(String mainUpjang) {
		this.mainUpjang = mainUpjang;
	}

	/**
	 * mainUpjangNm 얻기
	 *
	 * @return the mainUpjangNm
	 */
	public String getMainUpjangNm() {
		return mainUpjangNm;
	}

	/**
	 * mainUpjangNm 설정
	 *
	 * @param mainUpjangNm the mainUpjangNm to set
	 */
	public void setMainUpjangNm(String mainUpjangNm) {
		this.mainUpjangNm = mainUpjangNm;
	}

	/**
	 * muCd 얻기
	 *
	 * @return the muCd
	 */
	public String getMuCd() {
		return muCd;
	}

	/**
	 * muCd 설정
	 *
	 * @param muCd the muCd to set
	 */
	public void setMuCd(String muCd) {
		this.muCd = muCd;
	}

	/**
	 * muNm 얻기
	 *
	 * @return the muNm
	 */
	public String getMuNm() {
		return muNm;
	}

	/**
	 * muNm 설정
	 *
	 * @param muNm the muNm to set
	 */
	public void setMuNm(String muNm) {
		this.muNm = muNm;
	}

	/**
	 * otCustCd 얻기
	 *
	 * @return the otCustCd
	 */
	public String getOtCustCd() {
		return otCustCd;
	}

	/**
	 * otCustCd 설정
	 *
	 * @param otCustCd the otCustCd to set
	 */
	public void setOtCustCd(String otCustCd) {
		this.otCustCd = otCustCd;
	}

	/**
	 * otCustNm 얻기
	 *
	 * @return the otCustNm
	 */
	public String getOtCustNm() {
		return otCustNm;
	}

	/**
	 * otCustNm 설정
	 *
	 * @param otCustNm the otCustNm to set
	 */
	public void setOtCustNm(String otCustNm) {
		this.otCustNm = otCustNm;
	}

	/**
	 * scCd 얻기
	 *
	 * @return the scCd
	 */
	public String getScCd() {
		return scCd;
	}

	/**
	 * scCd 설정
	 *
	 * @param scCd the scCd to set
	 */
	public void setScCd(String scCd) {
		this.scCd = scCd;
	}

	/**
	 * scNm 얻기
	 *
	 * @return the scNm
	 */
	public String getScNm() {
		return scNm;
	}

	/**
	 * scNm 설정
	 *
	 * @param scNm the scNm to set
	 */
	public void setScNm(String scNm) {
		this.scNm = scNm;
	}

	/**
	 * tmCd 얻기
	 *
	 * @return the tmCd
	 */
	public String getTmCd() {
		return tmCd;
	}

	/**
	 * tmCd 설정
	 *
	 * @param tmCd the tmCd to set
	 */
	public void setTmCd(String tmCd) {
		this.tmCd = tmCd;
	}

	/**
	 * tmNm 얻기
	 *
	 * @return the tmNm
	 */
	public String getTmNm() {
		return tmNm;
	}

	/**
	 * tmNm 설정
	 *
	 * @param tmNm the tmNm to set
	 */
	public void setTmNm(String tmNm) {
		this.tmNm = tmNm;
	}

	/**
	 * upjang 얻기
	 *
	 * @return the upjang
	 */
	public String getUpjang() {
		return this.upjang;
	}

	/**
	 * upjang 설정
	 *
	 * @param upjang the upjang to set
	 */
	public void setUpjang(String upjang) {
		this.upjang = upjang;
	}

	/**
	 * upjangGroup 얻기
	 *
	 * @return the upjangGroup
	 */
	public String getUpjangGroup() {
		return this.upjangGroup;
	}

	/**
	 * upjangGroup 설정
	 *
	 * @param upjangGroup the upjangGroup to set
	 */
	public void setUpjangGroup(String upjangGroup) {
		this.upjangGroup = upjangGroup;
	}

	/**
	 * upjangNm 얻기
	 *
	 * @return the upjangNm
	 */
	public String getUpjangNm() {
		return upjangNm;
	}

	/**
	 * upjangNm 설정
	 *
	 * @param upjangNm the upjangNm to set
	 */
	public void setUpjangNm(String upjangNm) {
		this.upjangNm = upjangNm;
	}

	/**
	 * userGroup 얻기
	 *
	 * @return the userGroup
	 */
	public String getUserGroup() {
		return userGroup;
	}

	/**
	 * userGroup 설정
	 *
	 * @param userGroup the userGroup to set
	 */
	public void setUserGroup(String userGroup) {
		this.userGroup = userGroup;
	}

	/**
	 * userKind 얻기
	 *
	 * @return the userKind
	 */
	public String getUserKind() {
		return userKind;
	}

	/**
	 * userKind 설정
	 *
	 * @param userKind the userKind to set
	 */
	public void setUserKind(String userKind) {
		this.userKind = userKind;
	}

	/**
	 * simplePoYn 얻기
	 *
	 * @return the simplePoYn
	 */
	public String getSimplePoYn() {
		return simplePoYn;
	}

	/**
	 * simplePoYn 설정
	 *
	 * @param simplePoYn the simplePoYn to set
	 */
	public void setSimplePoYn(String simplePoYn) {
		this.simplePoYn = simplePoYn;
	}

	/**
	 * persInfoAgreeYn 얻기
	 *
	 * @return the persInfoAgreeYn
	 */
	public String getPersInfoAgreeYn() {
		return persInfoAgreeYn;
	}

	/**
	 * persInfoAgreeYn 설정
	 *
	 * @param persInfoAgreeYn the persInfoAgreeYn to set
	 */
	public void setPersInfoAgreeYn(String persInfoAgreeYn) {
		this.persInfoAgreeYn = persInfoAgreeYn;
	}

	/**
	 * persInfoProcLevel 얻기
	 *
	 * @return the persInfoProcLevel
	 */
	public String getPersInfoProcLevel() {
		return persInfoProcLevel;
	}

	/**
	 * persInfoProcLevel 설정
	 *
	 * @param persInfoProcLevel the persInfoProcLevel to set
	 */
	public void setPersInfoProcLevel(String persInfoProcLevel) {
		this.persInfoProcLevel = persInfoProcLevel;
	}

	/**
	 * persInfoProcGrade 얻기
	 *
	 * @return the persInfoProcGrade
	 */
	public String getPersInfoProcGrade() {
		return persInfoProcGrade;
	}

	/**
	 * persInfoProcGrade 설정
	 *
	 * @param persInfoProcGrade the persInfoProcGrade to set
	 */
	public void setPersInfoProcGrade(String persInfoProcGrade) {
		this.persInfoProcGrade = persInfoProcGrade;
	}

	/**
	 * persInfoMask 얻기
	 *
	 * @return the persInfoMask
	 */
	public String getPersInfoMask() {
		return persInfoMask;
	}

	/**
	 * persInfoMask 설정
	 *
	 * @param persInfoMask the persInfoMask to set
	 */
	public void setPersInfoMask(String persInfoMask) {
		this.persInfoMask = persInfoMask;
	}

	/**
	 * userType 얻기
	 *
	 * @return the userType
	 */
	public String getUserType() {
		return userType;
	}

	/**
	 * userType 설정
	 *
	 * @param userType the userType to set
	 */
	public void setUserType(String userType) {
		this.userType = userType;
	}

	/**
	 * authLevels 얻기
	 *
	 * @return the authLevels
	 */
	public String getAuthLevels() {
		return authLevels;
	}

	/**
	 * authLevels 설정
	 *
	 * @param authLevels the authLevels to set
	 */
	public void setAuthLevels(String authLevels) {
		this.authLevels = authLevels;
	}

	/**
	 * validPwdYn 얻기
	 *
	 * @return the validPwdYn
	 */
	public String getValidPwdYn() {
		return validPwdYn;
	}

	/**
	 * validPwdYn 설정
	 *
	 * @param validPwdYn the validPwdYn to set
	 */
	public void setValidPwdYn(String validPwdYn) {
		this.validPwdYn = validPwdYn;
	}

	/**
	 * pwdErrCnt 얻기
	 *
	 * @return the pwdErrCnt
	 */
	public int getPwdErrCnt() {
		return pwdErrCnt;
	}

	/**
	 * pwdErrCnt 설정
	 *
	 * @param pwdErrCnt the pwdErrCnt to set
	 */
	public void setPwdErrCnt(int pwdErrCnt) {
		this.pwdErrCnt = pwdErrCnt;
	}


	/**
	 * pwdChgYn 얻기
	 *
	 * @return the pwdChgYn
	 */
	public String getPwdChgYn() {
		return pwdChgYn;
	}

	/**
	 * pwdChgYn 설정
	 *
	 * @param pwdChgYn the pwdChgYn to set
	 */
	public void setPwdChgYn(String pwdChgYn) {
		this.pwdChgYn = pwdChgYn;
	}

	/**
	 * pwdChgDate 얻기
	 *
	 * @return the pwdChgDate
	 */
	public String getPwdChgDate() {
		return pwdChgDate;
	}

	/**
	 * pwdChgDate 설정
	 *
	 * @param pwdChgDate the pwdChgDate to set
	 */
	public void setPwdChgDate(String pwdChgDate) {
		this.pwdChgDate = pwdChgDate;
	}

	/**
	 * maxPwdErrCnt 얻기
	 *
	 * @return the maxPwdErrCnt
	 */
	public int getMaxPwdErrCnt() {
		return maxPwdErrCnt;
	}

	/**
	 * maxPwdErrCnt 설정
	 *
	 * @param maxPwdErrCnt the maxPwdErrCnt to set
	 */
	public void setMaxPwdErrCnt(int maxPwdErrCnt) {
		this.maxPwdErrCnt = maxPwdErrCnt;
	}

	/**
	 * resultCode 얻기
	 *
	 * @return the resultCode
	 */
	public int getResultCode() {
		return resultCode;
	}

	/**
	 * resultCode 설정
	 *
	 * @param resultCode the resultCode to set
	 */
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}

	/**
	 * acctStatus 얻기
	 *
	 * @return the acctStatus
	 */
	public String getAcctStatus() {
		return acctStatus;
	}

	/**
	 * acctStatus 설정
	 *
	 * @param acctStatus the acctStatus to set
	 */
	public void setAcctStatus(String acctStatus) {
		this.acctStatus = acctStatus;
	}

	/**
	 * acctLkReasonCd 얻기
	 *
	 * @return the acctLkReasonCd
	 */
	public String getAcctLkReasonCd() {
		return acctLkReasonCd;
	}

	/**
	 * acctLkReasonCd 설정
	 *
	 * @param acctLkReasonCd the acctLkReasonCd to set
	 */
	public void setAcctLkReasonCd(String acctLkReasonCd) {
		this.acctLkReasonCd = acctLkReasonCd;
	}

	/**
	 * manageAllowIp 얻기
	 *
	 * @return the manageAllowIp
	 */
	public String getManageAllowIp() {
		return manageAllowIp;
	}

	/**
	 * manageAllowIp 설정
	 *
	 * @param manageAllowIp the manageAllowIp to set
	 */
	public void setManageAllowIp(String manageAllowIp) {
		this.manageAllowIp = manageAllowIp;
	}

	/**
	 * alreadyLoginYn 얻기
	 *
	 * @return the alreadyLoginYn
	 */
	public String getAlreadyLoginYn() {
		return alreadyLoginYn;
	}

	/**
	 * alreadyLoginYn 설정
	 *
	 * @param alreadyLoginYn the alreadyLoginYn to set
	 */
	public void setAlreadyLoginYn(String alreadyLoginYn) {
		this.alreadyLoginYn = alreadyLoginYn;
	}

	/**
	 * alreadyLoginDate 얻기
	 *
	 * @return the alreadyLoginDate
	 */
	public String getAlreadyLoginDate() {
		return alreadyLoginDate;
	}

	/**
	 * alreadyLoginDate 설정
	 *
	 * @param alreadyLoginDate the alreadyLoginDate to set
	 */
	public void setAlreadyLoginDate(String alreadyLoginDate) {
		this.alreadyLoginDate = alreadyLoginDate;
	}

	/**
	 * alreadyConnIp 얻기
	 *
	 * @return the alreadyConnIp
	 */
	public String getAlreadyConnIp() {
		return alreadyConnIp;
	}

	/**
	 * alreadyConnIp 설정
	 *
	 * @param alreadyConnIp the alreadyConnIp to set
	 */
	public void setAlreadyConnIp(String alreadyConnIp) {
		this.alreadyConnIp = alreadyConnIp;
	}

	/**
	 * systemMst 얻기
	 *
	 * @return the systemMst
	 */
	public String getSystemMst() {
		return systemMst;
	}

	/**
	 * systemMst 설정
	 *
	 * @param systemMst the systemMst to set
	 */
	public void setSystemMst(String systemMst) {
		this.systemMst = systemMst;
	}

	/**
	 * boardMst 얻기
	 *
	 * @return the boardMst
	 */
	public String getBoardMst() {
		return boardMst;
	}

	/**
	 * boardMst 설정
	 *
	 * @param boardMst the boardMst to set
	 */
	public void setBoardMst(String boardMst) {
		this.boardMst = boardMst;
	}

	/**
	 * tempSabunManageSabun 얻기
	 *
	 * @return the tempSabunManageSabun
	 */
	public String getTempSabunManageSabun() {
		return tempSabunManageSabun;
	}

	/**
	 * tempSabunManageSabun 설정
	 *
	 * @param tempSabunManageSabun the tempSabunManageSabun to set
	 */
	public void setTempSabunManageSabun(String tempSabunManageSabun) {
		this.tempSabunManageSabun = tempSabunManageSabun;
	}

	/**
	 * introPage 얻기
	 *
	 * @return the introPage
	 */
	public String getIntroPage() {
		return introPage;
	}

	/**
	 * introPage 설정
	 *
	 * @param introPage the introPage to set
	 */
	public void setIntroPage(String introPage) {
		this.introPage = introPage;
	}

	/**
	 * hpNo 얻기
	 *
	 * @return the hpNo
	 */
	public String getHpNo() {
		return hpNo;
	}

	/**
	 * hpNo 설정
	 *
	 * @param hpNo the hpNo to set
	 */
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}

	/**
	 * emailAddr 얻기
	 *
	 * @return the emailAddr
	 */
	public String getEmailAddr() {
		return emailAddr;
	}

	/**
	 * emailAddr 설정
	 *
	 * @param emailAddr the emailAddr to set
	 */
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}

	/**
	 * itctYn 얻기
	 *
	 * @return the itctYn
	 */
	public String getItctYn() {
		return itctYn;
	}

	/**
	 * itctYn 설정
	 *
	 * @param itctYn the itctYn to set
	 */
	public void setItctYn(String itctYn) {
		this.itctYn = itctYn;
	}

	/**
	 * useDateYn 얻기
	 *
	 * @return the useDateYn
	 */
	public String getUseDateYn() {
		return useDateYn;
	}

	/**
	 * useDateYn 설정
	 *
	 * @param useDateYn the useDateYn to set
	 */
	public void setUseDateYn(String useDateYn) {
		this.useDateYn = useDateYn;
	}

	/**
	 * useDate 얻기
	 *
	 * @return the useDate
	 */
	public String getUseDate() {
		return useDate;
	}

	/**
	 * useDate 설정
	 *
	 * @param useDate the useDate to set
	 */
	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}

	/**
	 * mainUpjangImg 얻기
	 *
	 * @return the mainUpjangImg
	 */
	public String getMainUpjangImg() {
		return mainUpjangImg;
	}

	/**
	 * mainUpjangImg 설정
	 *
	 * @param mainUpjangImg the mainUpjangImg to set
	 */
	public void setMainUpjangImg(String mainUpjangImg) {
		this.mainUpjangImg = mainUpjangImg;
	}

	/**
	 * sysTypeCnt 얻기
	 *
	 * @return the sysTypeCnt
	 */
	public String getSysTypeCnt() {
		return sysTypeCnt;
	}

	/**
	 * sysTypeCnt 설정
	 *
	 * @param sysTypeCnt the sysTypeCnt to set
	 */
	public void setSysTypeCnt(String sysTypeCnt) {
		this.sysTypeCnt = sysTypeCnt;
	}

	/**
	 * upjangCnt 얻기
	 *
	 * @return the upjangCnt
	 */
	public String getUpjangCnt() {
		return upjangCnt;
	}

	/**
	 * upjangCnt 설정
	 *
	 * @param upjangCnt the upjangCnt to set
	 */
	public void setUpjangCnt(String upjangCnt) {
		this.upjangCnt = upjangCnt;
	}

	/**
	 * userRoles 얻기
	 *
	 * @return the userRoles
	 */
	public String getUserRoles() {
		return userRoles;
	}

	/**
	 * userRoles 설정
	 *
	 * @param userRoles the userRoles to set
	 */
	public void setUserRoles(String userRoles) {
		this.userRoles = userRoles;
	}

	/**
	 * applyAuthYn 얻기
	 *
	 * @return the applyAuthYn
	 */
	public String getApplyAuthYn() {
		return applyAuthYn;
	}

	/**
	 * applyAuthYn 설정
	 *
	 * @param applyAuthYn the applyAuthYn to set
	 */
	public void setApplyAuthYn(String applyAuthYn) {
		this.applyAuthYn = applyAuthYn;
	}

	/**
	 * ptCd 얻기
	 *
	 * @return the ptCd
	 */
	public String getPtCd() {
		return ptCd;
	}

	/**
	 * ptCd 설정
	 *
	 * @param ptCd the ptCd to set
	 */
	public void setPtCd(String ptCd) {
		this.ptCd = ptCd;
	}

	/**
	 * ptNm 얻기
	 *
	 * @return the ptNm
	 */
	public String getPtNm() {
		return ptNm;
	}

	/**
	 * ptNm 설정
	 *
	 * @param ptNm the ptNm to set
	 */
	public void setPtNm(String ptNm) {
		this.ptNm = ptNm;
	}

	/**
	 * slipSabun 얻기
	 *
	 * @return the slipSabun
	 */
	public String getSlipSabun() {
		return slipSabun;
	}

	/**
	 * slipSabun 설정
	 *
	 * @param slipSabun the slipSabun to set
	 */
	public void setSlipSabun(String slipSabun) {
		this.slipSabun = slipSabun;
	}
	
	
	/**
	 * gntCd 얻기
	 *
	 * @return the gntCd
	 */
	public String getGntCd() {
		return gntCd;
	}

	/**
	 * gntCd 설정
	 *
	 * @param gntCd the gntCd to set
	 */
	public void setGntCd(String gntCd) {
		this.gntCd = gntCd;
	}

	/**
	 * gntNm 얻기
	 *
	 * @return the gntNm
	 */
	public String getGntNm() {
		return gntNm;
	}

	/**
	 * gntNm 설정
	 *
	 * @param gntNm the gntNm to set
	 */
	public void setGntNm(String gntNm) {
		this.gntNm = gntNm;
	}
	/**
	 * nGntCd 얻기
	 *
	 * @return the nGntCd
	 */
	public String getnGntCd() {
		return nGntCd;
	}

	/**
	 * nGntCd 설정
	 *
	 * @param nGntCd the nGntCd to set
	 */
	public void setnGntCd(String nGntCd) {
		this.nGntCd = nGntCd;
	}

	/**
	 * nGntNm 얻기
	 *
	 * @return the nGntNm
	 */
	public String getnGntNm() {
		return nGntNm;
	}

	/**
	 * nGntNm 설정
	 *
	 * @param nGntNm the nGntNm to set
	 */
	public void setnGntNm(String nGntNm) {
		this.nGntNm = nGntNm;
	}

	/**
	 * gntYn 얻기
	 *
	 * @return the gntYn
	 */
	public String getGntYn() {
		return gntYn;
	}

	/**
	 * gntYn 설정
	 *
	 * @param gntYn the gntYn to set
	 */
	public void setGntYn(String gntYn) {
		this.gntYn = gntYn;
	}

	
}
