package com.hwfs.sc.cmn.dto;

import java.io.Serializable;

/**
 * 신용카드 입반송 정보를 담고 있는 DTO
 * 
 * @ClassName CardReplyDTO.java
 * @Description CardReplyDTO Class
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
public class CardReplyDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String recordClCd; 			/* RECORD 구분 52 */
	private String fileWrtDt; 			/* 파일작성일(YYYYMMDD) */
	private String purchFmBizrNo; 		/* 매입카드회사 사업자등록번호 */
	private String joShopBizrNo; 		/* 가맹점 사업자등록번호 */
	private String rcptStaDt; 			/* 접수일자 FROM */
	private String rcptEndDt; 			/* 접수일자 TO */
	private String payPlanDt; 			/* 지급(예정)일자 */
	private String joShopNo; 			/* 가맹점번호 */
	private String crncyCd; 			/* 통화코드 410:원화, 840:달러화 */
	private String svcClCd; 			/* 서비스구분 DDC, DSC, EDI */
	private String salStaDt; 			/* 매출일자 FROM */
	private String salEndDt; 			/* 매출일자 TO */
	private String invDt; 				/* 청구일자 */
	private String purchFmCd; 			/* 매입사 코드 */
	private String finOrgEcd; 			/* 매입사 영문코드 */
	private String dtRecordClCd; 		/* RECORD 구분
										 60 : 매출정상 61 : 매출반송 62 : 매출보류
										 63 : 매출보류해제 ? 매출거래가 보류되었다가 추후에 해제되어 매입되는 경우
										 64 : 취소반송 취소거래가 반송되는 경우
										 65 : 취소보류 취소거래가 보류되는 경우
										 66 : 취소보류해제 취소거래가 보류되었다가 추후에 해제되어 취소 환급 처리되는 경우
										 */
	private String dtCrncyCd; 			/* 통화코드 410:원화, 840:달러화 */
	private String dtCrncyIdx; 			/* 통화지수 0:원화, 2:달러화 */
	private String dtSalDt; 			/* 매출(취소)일자 YYYYMMDD */
	private String dtRcptDt; 			/* 접수일자 */
	private String dtCardno; 			/* 카드번호 */
	private String dtAlotMonthsCnt; 	/* 할부기간 일반매출:00, 할부매출:02-36 */
	private String dtTotTrxAmt; 		/* 신용판매금액 거래금액 */
	private String dtCardfmRetRsnCd; 	/* 반송사유코드 */
	private String dtKiccRetRsnCd; 		/* 점포코드+가맹점임의정보 */
	private String dtUserDefCont1; 		/* 가맹점사용영역2 */
	private String dtUserDefCont2; 		/* 가맹점사용영역2 */
	private String dtAprvNo; 			/* 승인번호 */
	private String dtShopPosNo; 		/* 매장(POS)번호 */
	private String dtCmmsAmt; 			/* 건별수수료 - 매입정상:12자리숫자 매입취소정상:1자리기호(-)+11자리숫자 */
	private String dtTid; 				/* 단말기번호 */
	private String dtChnlUsedField; 	/* 추가필드 */
	private String dtCardTypCd; 		/* 카드구분 */
	private String ttRecordClCd; 		/* RECORD 구분 53 입금통지 */
	private String ttRcptCnt; 			/* A1 청구접수건수 */
	private String ttRcptAmt; 			/* B1 청구접수금액 */
	private String ttRetCnt; 			/* A2 반송건수 */
	private String ttRetAmt; 			/* B2 반송금액 */
	private String ttDfrCnt; 			/* A3 보류건수 */
	private String ttDfrAmt; 			/* B3 보류금액 */
	private String ttDfrRelseCnt; 		/* A4 보류해제건수 */
	private String ttDfrRelseAmt; 		/* B4 보류해제금액 */
	private String ttTotCnt; 			/* A5 합계건수 */
	private String ttTotAmt; 			/* B5 합계금액 */
	private String ttCmmsSamt; 			/* E 수수료합계 */
	private String ttPayAmt; 			/* F 입금액 */
	private String recdStat; 			/* 상태 */
	private String createBy; 			/* 등록자 */
	private String updateBy; 			/* 수정자 */
	private String compCd; 				/* 회사 코드 */
	private String sysTypeCd; 			/* 시스템 구분 코드 */
	private String brchCd; 				/* 사업장 코드 */
	private String rltnSeq;				/* 관계순서 */
	private String arNo;				/* 외상번호 */

	/**
	 * recordClCd 얻기
	 * 
	 * @return the recordClCd
	 */
	public String getRecordClCd() {
		return recordClCd;
	}

	/**
	 * recordClCd 설정
	 * 
	 * @param recordClCd
	 *            the recordClCd to set
	 */
	public void setRecordClCd(String recordClCd) {
		this.recordClCd = recordClCd;
	}

	/**
	 * fileWrtDt 얻기
	 * 
	 * @return the fileWrtDt
	 */
	public String getFileWrtDt() {
		return fileWrtDt;
	}

	/**
	 * fileWrtDt 설정
	 * 
	 * @param fileWrtDt
	 *            the fileWrtDt to set
	 */
	public void setFileWrtDt(String fileWrtDt) {
		this.fileWrtDt = fileWrtDt;
	}

	/**
	 * purchFmBizrNo 얻기
	 * 
	 * @return the purchFmBizrNo
	 */
	public String getPurchFmBizrNo() {
		return purchFmBizrNo;
	}

	/**
	 * purchFmBizrNo 설정
	 * 
	 * @param purchFmBizrNo
	 *            the purchFmBizrNo to set
	 */
	public void setPurchFmBizrNo(String purchFmBizrNo) {
		this.purchFmBizrNo = purchFmBizrNo;
	}

	/**
	 * joShopBizrNo 얻기
	 * 
	 * @return the joShopBizrNo
	 */
	public String getJoShopBizrNo() {
		return joShopBizrNo;
	}

	/**
	 * joShopBizrNo 설정
	 * 
	 * @param joShopBizrNo
	 *            the joShopBizrNo to set
	 */
	public void setJoShopBizrNo(String joShopBizrNo) {
		this.joShopBizrNo = joShopBizrNo;
	}

	/**
	 * rcptStaDt 얻기
	 * 
	 * @return the rcptStaDt
	 */
	public String getRcptStaDt() {
		return rcptStaDt;
	}

	/**
	 * rcptStaDt 설정
	 * 
	 * @param rcptStaDt
	 *            the rcptStaDt to set
	 */
	public void setRcptStaDt(String rcptStaDt) {
		this.rcptStaDt = rcptStaDt;
	}

	/**
	 * rcptEndDt 얻기
	 * 
	 * @return the rcptEndDt
	 */
	public String getRcptEndDt() {
		return rcptEndDt;
	}

	/**
	 * rcptEndDt 설정
	 * 
	 * @param rcptEndDt
	 *            the rcptEndDt to set
	 */
	public void setRcptEndDt(String rcptEndDt) {
		this.rcptEndDt = rcptEndDt;
	}

	/**
	 * payPlanDt 얻기
	 * 
	 * @return the payPlanDt
	 */
	public String getPayPlanDt() {
		return payPlanDt;
	}

	/**
	 * payPlanDt 설정
	 * 
	 * @param payPlanDt
	 *            the payPlanDt to set
	 */
	public void setPayPlanDt(String payPlanDt) {
		this.payPlanDt = payPlanDt;
	}

	/**
	 * joShopNo 얻기
	 * 
	 * @return the joShopNo
	 */
	public String getJoShopNo() {
		return joShopNo;
	}

	/**
	 * joShopNo 설정
	 * 
	 * @param joShopNo
	 *            the joShopNo to set
	 */
	public void setJoShopNo(String joShopNo) {
		this.joShopNo = joShopNo;
	}

	/**
	 * crncyCd 얻기
	 * 
	 * @return the crncyCd
	 */
	public String getCrncyCd() {
		return crncyCd;
	}

	/**
	 * crncyCd 설정
	 * 
	 * @param crncyCd
	 *            the crncyCd to set
	 */
	public void setCrncyCd(String crncyCd) {
		this.crncyCd = crncyCd;
	}

	/**
	 * svcClCd 얻기
	 * 
	 * @return the svcClCd
	 */
	public String getSvcClCd() {
		return svcClCd;
	}

	/**
	 * svcClCd 설정
	 * 
	 * @param svcClCd
	 *            the svcClCd to set
	 */
	public void setSvcClCd(String svcClCd) {
		this.svcClCd = svcClCd;
	}

	/**
	 * salStaDt 얻기
	 * 
	 * @return the salStaDt
	 */
	public String getSalStaDt() {
		return salStaDt;
	}

	/**
	 * salStaDt 설정
	 * 
	 * @param salStaDt
	 *            the salStaDt to set
	 */
	public void setSalStaDt(String salStaDt) {
		this.salStaDt = salStaDt;
	}

	/**
	 * salEndDt 얻기
	 * 
	 * @return the salEndDt
	 */
	public String getSalEndDt() {
		return salEndDt;
	}

	/**
	 * salEndDt 설정
	 * 
	 * @param salEndDt
	 *            the salEndDt to set
	 */
	public void setSalEndDt(String salEndDt) {
		this.salEndDt = salEndDt;
	}

	/**
	 * invDt 얻기
	 * 
	 * @return the invDt
	 */
	public String getInvDt() {
		return invDt;
	}

	/**
	 * invDt 설정
	 * 
	 * @param invDt
	 *            the invDt to set
	 */
	public void setInvDt(String invDt) {
		this.invDt = invDt;
	}

	/**
	 * purchFmCd 얻기
	 * 
	 * @return the purchFmCd
	 */
	public String getPurchFmCd() {
		return purchFmCd;
	}

	/**
	 * purchFmCd 설정
	 * 
	 * @param purchFmCd
	 *            the purchFmCd to set
	 */
	public void setPurchFmCd(String purchFmCd) {
		this.purchFmCd = purchFmCd;
	}

	/**
	 * finOrgEcd 얻기
	 * 
	 * @return the finOrgEcd
	 */
	public String getFinOrgEcd() {
		return finOrgEcd;
	}

	/**
	 * finOrgEcd 설정
	 * 
	 * @param finOrgEcd
	 *            the finOrgEcd to set
	 */
	public void setFinOrgEcd(String finOrgEcd) {
		this.finOrgEcd = finOrgEcd;
	}

	/**
	 * dtRecordClCd 얻기
	 * 
	 * @return the dtRecordClCd
	 */
	public String getDtRecordClCd() {
		return dtRecordClCd;
	}

	/**
	 * dtRecordClCd 설정
	 * 
	 * @param dtRecordClCd
	 *            the dtRecordClCd to set
	 */
	public void setDtRecordClCd(String dtRecordClCd) {
		this.dtRecordClCd = dtRecordClCd;
	}

	/**
	 * dtCrncyCd 얻기
	 * 
	 * @return the dtCrncyCd
	 */
	public String getDtCrncyCd() {
		return dtCrncyCd;
	}

	/**
	 * dtCrncyCd 설정
	 * 
	 * @param dtCrncyCd
	 *            the dtCrncyCd to set
	 */
	public void setDtCrncyCd(String dtCrncyCd) {
		this.dtCrncyCd = dtCrncyCd;
	}

	/**
	 * dtCrncyIdx 얻기
	 * 
	 * @return the dtCrncyIdx
	 */
	public String getDtCrncyIdx() {
		return dtCrncyIdx;
	}

	/**
	 * dtCrncyIdx 설정
	 * 
	 * @param dtCrncyIdx
	 *            the dtCrncyIdx to set
	 */
	public void setDtCrncyIdx(String dtCrncyIdx) {
		this.dtCrncyIdx = dtCrncyIdx;
	}

	/**
	 * dtSalDt 얻기
	 * 
	 * @return the dtSalDt
	 */
	public String getDtSalDt() {
		return dtSalDt;
	}

	/**
	 * dtSalDt 설정
	 * 
	 * @param dtSalDt
	 *            the dtSalDt to set
	 */
	public void setDtSalDt(String dtSalDt) {
		this.dtSalDt = dtSalDt;
	}

	/**
	 * dtRcptDt 얻기
	 * 
	 * @return the dtRcptDt
	 */
	public String getDtRcptDt() {
		return dtRcptDt;
	}

	/**
	 * dtRcptDt 설정
	 * 
	 * @param dtRcptDt
	 *            the dtRcptDt to set
	 */
	public void setDtRcptDt(String dtRcptDt) {
		this.dtRcptDt = dtRcptDt;
	}

	/**
	 * dtCardno 얻기
	 * 
	 * @return the dtCardno
	 */
	public String getDtCardno() {
		return dtCardno;
	}

	/**
	 * dtCardno 설정
	 * 
	 * @param dtCardno
	 *            the dtCardno to set
	 */
	public void setDtCardno(String dtCardno) {
		this.dtCardno = dtCardno;
	}

	/**
	 * dtAlotMonthsCnt 얻기
	 * 
	 * @return the dtAlotMonthsCnt
	 */
	public String getDtAlotMonthsCnt() {
		return dtAlotMonthsCnt;
	}

	/**
	 * dtAlotMonthsCnt 설정
	 * 
	 * @param dtAlotMonthsCnt
	 *            the dtAlotMonthsCnt to set
	 */
	public void setDtAlotMonthsCnt(String dtAlotMonthsCnt) {
		this.dtAlotMonthsCnt = dtAlotMonthsCnt;
	}

	/**
	 * dtTotTrxAmt 얻기
	 * 
	 * @return the dtTotTrxAmt
	 */
	public String getDtTotTrxAmt() {
		return dtTotTrxAmt;
	}

	/**
	 * dtTotTrxAmt 설정
	 * 
	 * @param dtTotTrxAmt
	 *            the dtTotTrxAmt to set
	 */
	public void setDtTotTrxAmt(String dtTotTrxAmt) {
		this.dtTotTrxAmt = dtTotTrxAmt;
	}

	/**
	 * dtCardfmRetRsnCd 얻기
	 * 
	 * @return the dtCardfmRetRsnCd
	 */
	public String getDtCardfmRetRsnCd() {
		return dtCardfmRetRsnCd;
	}

	/**
	 * dtCardfmRetRsnCd 설정
	 * 
	 * @param dtCardfmRetRsnCd
	 *            the dtCardfmRetRsnCd to set
	 */
	public void setDtCardfmRetRsnCd(String dtCardfmRetRsnCd) {
		this.dtCardfmRetRsnCd = dtCardfmRetRsnCd;
	}

	/**
	 * dtKiccRetRsnCd 얻기
	 * 
	 * @return the dtKiccRetRsnCd
	 */
	public String getDtKiccRetRsnCd() {
		return dtKiccRetRsnCd;
	}

	/**
	 * dtKiccRetRsnCd 설정
	 * 
	 * @param dtKiccRetRsnCd
	 *            the dtKiccRetRsnCd to set
	 */
	public void setDtKiccRetRsnCd(String dtKiccRetRsnCd) {
		this.dtKiccRetRsnCd = dtKiccRetRsnCd;
	}

	/**
	 * dtUserDefCont1 얻기
	 * 
	 * @return the dtUserDefCont1
	 */
	public String getDtUserDefCont1() {
		return dtUserDefCont1;
	}

	/**
	 * dtUserDefCont1 설정
	 * 
	 * @param dtUserDefCont1
	 *            the dtUserDefCont1 to set
	 */
	public void setDtUserDefCont1(String dtUserDefCont1) {
		this.dtUserDefCont1 = dtUserDefCont1;
	}

	/**
	 * dtUserDefCont2 얻기
	 * 
	 * @return the dtUserDefCont2
	 */
	public String getDtUserDefCont2() {
		return dtUserDefCont2;
	}

	/**
	 * dtUserDefCont2 설정
	 * 
	 * @param dtUserDefCont2
	 *            the dtUserDefCont2 to set
	 */
	public void setDtUserDefCont2(String dtUserDefCont2) {
		this.dtUserDefCont2 = dtUserDefCont2;
	}

	/**
	 * dtAprvNo 얻기
	 * 
	 * @return the dtAprvNo
	 */
	public String getDtAprvNo() {
		return dtAprvNo;
	}

	/**
	 * dtAprvNo 설정
	 * 
	 * @param dtAprvNo
	 *            the dtAprvNo to set
	 */
	public void setDtAprvNo(String dtAprvNo) {
		this.dtAprvNo = dtAprvNo;
	}

	/**
	 * dtShopPosNo 얻기
	 * 
	 * @return the dtShopPosNo
	 */
	public String getDtShopPosNo() {
		return dtShopPosNo;
	}

	/**
	 * dtShopPosNo 설정
	 * 
	 * @param dtShopPosNo
	 *            the dtShopPosNo to set
	 */
	public void setDtShopPosNo(String dtShopPosNo) {
		this.dtShopPosNo = dtShopPosNo;
	}

	/**
	 * dtCmmsAmt 얻기
	 * 
	 * @return the dtCmmsAmt
	 */
	public String getDtCmmsAmt() {
		return dtCmmsAmt;
	}

	/**
	 * dtCmmsAmt 설정
	 * 
	 * @param dtCmmsAmt
	 *            the dtCmmsAmt to set
	 */
	public void setDtCmmsAmt(String dtCmmsAmt) {
		this.dtCmmsAmt = dtCmmsAmt;
	}

	/**
	 * dtTid 얻기
	 * 
	 * @return the dtTid
	 */
	public String getDtTid() {
		return dtTid;
	}

	/**
	 * dtTid 설정
	 * 
	 * @param dtTid
	 *            the dtTid to set
	 */
	public void setDtTid(String dtTid) {
		this.dtTid = dtTid;
	}

	/**
	 * dtChnlUsedField 얻기
	 * 
	 * @return the dtChnlUsedField
	 */
	public String getDtChnlUsedField() {
		return dtChnlUsedField;
	}

	/**
	 * dtChnlUsedField 설정
	 * 
	 * @param dtChnlUsedField
	 *            the dtChnlUsedField to set
	 */
	public void setDtChnlUsedField(String dtChnlUsedField) {
		this.dtChnlUsedField = dtChnlUsedField;
	}

	/**
	 * dtCardTypCd 얻기
	 * 
	 * @return the dtCardTypCd
	 */
	public String getDtCardTypCd() {
		return dtCardTypCd;
	}

	/**
	 * dtCardTypCd 설정
	 * 
	 * @param dtCardTypCd
	 *            the dtCardTypCd to set
	 */
	public void setDtCardTypCd(String dtCardTypCd) {
		this.dtCardTypCd = dtCardTypCd;
	}

	/**
	 * ttRecordClCd 얻기
	 * 
	 * @return the ttRecordClCd
	 */
	public String getTtRecordClCd() {
		return ttRecordClCd;
	}

	/**
	 * ttRecordClCd 설정
	 * 
	 * @param ttRecordClCd
	 *            the ttRecordClCd to set
	 */
	public void setTtRecordClCd(String ttRecordClCd) {
		this.ttRecordClCd = ttRecordClCd;
	}

	/**
	 * ttRcptCnt 얻기
	 * 
	 * @return the ttRcptCnt
	 */
	public String getTtRcptCnt() {
		return ttRcptCnt;
	}

	/**
	 * ttRcptCnt 설정
	 * 
	 * @param ttRcptCnt
	 *            the ttRcptCnt to set
	 */
	public void setTtRcptCnt(String ttRcptCnt) {
		this.ttRcptCnt = ttRcptCnt;
	}

	/**
	 * ttRcptAmt 얻기
	 * 
	 * @return the ttRcptAmt
	 */
	public String getTtRcptAmt() {
		return ttRcptAmt;
	}

	/**
	 * ttRcptAmt 설정
	 * 
	 * @param ttRcptAmt
	 *            the ttRcptAmt to set
	 */
	public void setTtRcptAmt(String ttRcptAmt) {
		this.ttRcptAmt = ttRcptAmt;
	}

	/**
	 * ttRetCnt 얻기
	 * 
	 * @return the ttRetCnt
	 */
	public String getTtRetCnt() {
		return ttRetCnt;
	}

	/**
	 * ttRetCnt 설정
	 * 
	 * @param ttRetCnt
	 *            the ttRetCnt to set
	 */
	public void setTtRetCnt(String ttRetCnt) {
		this.ttRetCnt = ttRetCnt;
	}

	/**
	 * ttRetAmt 얻기
	 * 
	 * @return the ttRetAmt
	 */
	public String getTtRetAmt() {
		return ttRetAmt;
	}

	/**
	 * ttRetAmt 설정
	 * 
	 * @param ttRetAmt
	 *            the ttRetAmt to set
	 */
	public void setTtRetAmt(String ttRetAmt) {
		this.ttRetAmt = ttRetAmt;
	}

	/**
	 * ttDfrCnt 얻기
	 * 
	 * @return the ttDfrCnt
	 */
	public String getTtDfrCnt() {
		return ttDfrCnt;
	}

	/**
	 * ttDfrCnt 설정
	 * 
	 * @param ttDfrCnt
	 *            the ttDfrCnt to set
	 */
	public void setTtDfrCnt(String ttDfrCnt) {
		this.ttDfrCnt = ttDfrCnt;
	}

	/**
	 * ttDfrAmt 얻기
	 * 
	 * @return the ttDfrAmt
	 */
	public String getTtDfrAmt() {
		return ttDfrAmt;
	}

	/**
	 * ttDfrAmt 설정
	 * 
	 * @param ttDfrAmt
	 *            the ttDfrAmt to set
	 */
	public void setTtDfrAmt(String ttDfrAmt) {
		this.ttDfrAmt = ttDfrAmt;
	}

	/**
	 * ttDfrRelseCnt 얻기
	 * 
	 * @return the ttDfrRelseCnt
	 */
	public String getTtDfrRelseCnt() {
		return ttDfrRelseCnt;
	}

	/**
	 * ttDfrRelseCnt 설정
	 * 
	 * @param ttDfrRelseCnt
	 *            the ttDfrRelseCnt to set
	 */
	public void setTtDfrRelseCnt(String ttDfrRelseCnt) {
		this.ttDfrRelseCnt = ttDfrRelseCnt;
	}

	/**
	 * ttDfrRelseAmt 얻기
	 * 
	 * @return the ttDfrRelseAmt
	 */
	public String getTtDfrRelseAmt() {
		return ttDfrRelseAmt;
	}

	/**
	 * ttDfrRelseAmt 설정
	 * 
	 * @param ttDfrRelseAmt
	 *            the ttDfrRelseAmt to set
	 */
	public void setTtDfrRelseAmt(String ttDfrRelseAmt) {
		this.ttDfrRelseAmt = ttDfrRelseAmt;
	}

	/**
	 * ttTotCnt 얻기
	 * 
	 * @return the ttTotCnt
	 */
	public String getTtTotCnt() {
		return ttTotCnt;
	}

	/**
	 * ttTotCnt 설정
	 * 
	 * @param ttTotCnt
	 *            the ttTotCnt to set
	 */
	public void setTtTotCnt(String ttTotCnt) {
		this.ttTotCnt = ttTotCnt;
	}

	/**
	 * ttTotAmt 얻기
	 * 
	 * @return the ttTotAmt
	 */
	public String getTtTotAmt() {
		return ttTotAmt;
	}

	/**
	 * ttTotAmt 설정
	 * 
	 * @param ttTotAmt
	 *            the ttTotAmt to set
	 */
	public void setTtTotAmt(String ttTotAmt) {
		this.ttTotAmt = ttTotAmt;
	}

	/**
	 * ttCmmsSamt 얻기
	 * 
	 * @return the ttCmmsSamt
	 */
	public String getTtCmmsSamt() {
		return ttCmmsSamt;
	}

	/**
	 * ttCmmsSamt 설정
	 * 
	 * @param ttCmmsSamt
	 *            the ttCmmsSamt to set
	 */
	public void setTtCmmsSamt(String ttCmmsSamt) {
		this.ttCmmsSamt = ttCmmsSamt;
	}

	/**
	 * ttPayAmt 얻기
	 * 
	 * @return the ttPayAmt
	 */
	public String getTtPayAmt() {
		return ttPayAmt;
	}

	/**
	 * ttPayAmt 설정
	 * 
	 * @param ttPayAmt
	 *            the ttPayAmt to set
	 */
	public void setTtPayAmt(String ttPayAmt) {
		this.ttPayAmt = ttPayAmt;
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
	 * @param recdStat
	 *            the recdStat to set
	 */
	public void setRecdStat(String recdStat) {
		this.recdStat = recdStat;
	}

	/**
	 * createBy 얻기
	 * 
	 * @return the createBy
	 */
	public String getCreateBy() {
		return createBy;
	}

	/**
	 * createBy 설정
	 * 
	 * @param createBy
	 *            the createBy to set
	 */
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	/**
	 * updateBy 얻기
	 * 
	 * @return the updateBy
	 */
	public String getUpdateBy() {
		return updateBy;
	}

	/**
	 * updateBy 설정
	 * 
	 * @param updateBy
	 *            the updateBy to set
	 */
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

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
	 * @param compCd
	 *            the compCd to set
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
	 * @param sysTypeCd
	 *            the sysTypeCd to set
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
	 * @param brchCd
	 *            the brchCd to set
	 */
	public void setBrchCd(String brchCd) {
		this.brchCd = brchCd;
	}

	/**
	 * rltnSeq 얻기
	 *
	 * @return the rltnSeq
	 */
	public String getRltnSeq() {
		return rltnSeq;
	}

	/**
	 * rltnSeq 설정
	 *
	 * @param rltnSeq the rltnSeq to set
	 */
	public void setRltnSeq(String rltnSeq) {
		this.rltnSeq = rltnSeq;
	}

	/**
	 * arNo 얻기
	 *
	 * @return the arNo
	 */
	public String getArNo() {
		return arNo;
	}

	/**
	 * arNo 설정
	 *
	 * @param arNo the arNo to set
	 */
	public void setArNo(String arNo) {
		this.arNo = arNo;
	}
	
}