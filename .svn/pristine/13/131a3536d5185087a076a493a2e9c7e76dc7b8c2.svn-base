package com.hwfs.sc.cmn.sap.request;

import java.io.Serializable;
import java.math.BigDecimal;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hwfs.sc.cmn.sap.EAIRequest;

 /**
 * InOutDescRequest에 대한 설명 작성
 * @ClassName InOutDescRequest.java
 * @Description InOutDescRequest Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 13.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 8. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class InOutDescRequest implements Serializable, EAIRequest {
	private static final long serialVersionUID = 1L;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//private String sysCd = "IPO";
	private String typ = "";
	private String docNo = "";
	private String docLno = "";
	private String poClose = "";
	private String poCancl = "";
	private String slipYn = "";
	private String ccCd = "";
	private String ioNo = "";
	private String accCd = "";
	private BigDecimal qty = BigDecimal.ZERO;
	private String unit = "";
	private BigDecimal uPrice = BigDecimal.ZERO;
	private BigDecimal amt = BigDecimal.ZERO;
	private String cur = "";
	private String regDt = "";
	private String grFDt = "";
	private String mvt = "";
	private String prNo = "";
	private String prLno = "";
	private String poNo = "";
	private String poLno = "";
	
	/**
	 * getInterfaceId 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getInterfaceId()
	*/
	@Override
	public String getInterfaceId() {
		return "FCM_CO_008_02";
	}

	/**
	 * getJSONObject 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param systemCode
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.sap.EAIRequest#getJSONObject(java.lang.String)
	*/
	@Override
	public JSONObject getJSONObject(String systemCode) throws Exception {
		JSONObject value = new JSONObject();
		JSONObject item = new JSONObject();

		try {
			value.put("SYS_CD", "IPO");
			value.put("TYP", this.typ);
			value.put("DOC_NO", this.docNo);
			value.put("DOC_LNO", this.docLno);
			value.put("PO_CLOSE", this.poClose);
			value.put("PO_CANCL", this.poCancl);
			value.put("SLIP_YN", this.slipYn);
			value.put("CC_CD", this.ccCd);
			value.put("IO_NO", this.ioNo);
			value.put("ACC_CD", this.accCd);
			value.put("QTY", this.qty);
			value.put("UNIT", this.unit);
			value.put("U_PRICE", this.uPrice);
			value.put("AMT", this.amt);
			value.put("CUR", this.cur);
			value.put("REG_DT", this.regDt);
			value.put("GR_F_DT", this.grFDt);
			value.put("MVT", this.mvt);
			value.put("PR_NO", this.prNo);
			value.put("PR_LNO", this.prLno);
			value.put("PO_NO", this.poNo);
			value.put("PO_LNO", this.poLno);
			
			item.put("ITEM01", value);
		}
		catch (JSONException e) {
			logger.debug(e.getMessage());
			throw e;
		}

		return item;
	}

//	/**
//	 * sysCd 얻기
//	 *
//	 * @return the sysCd
//	 */
//	public String getSysCd() {
//		return sysCd;
//	}
//
//	/**
//	 * sysCd 설정
//	 *
//	 * @param sysCd the sysCd to set
//	 */
//	public void setSysCd(String sysCd) {
//		this.sysCd = sysCd;
//	}

	/**
	 * typ 얻기
	 *
	 * @return the typ
	 */
	public String getTyp() {
		return typ;
	}

	/**
	 * typ 설정
	 *
	 * @param typ the typ to set
	 */
	public void setTyp(String typ) {
		this.typ = typ;
	}

	/**
	 * docNo 얻기
	 *
	 * @return the docNo
	 */
	public String getDocNo() {
		return docNo;
	}

	/**
	 * docNo 설정
	 *
	 * @param docNo the docNo to set
	 */
	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}

	/**
	 * docLno 얻기
	 *
	 * @return the docLno
	 */
	public String getDocLno() {
		return docLno;
	}

	/**
	 * docLno 설정
	 *
	 * @param docLno the docLno to set
	 */
	public void setDocLno(String docLno) {
		this.docLno = docLno;
	}

	/**
	 * poClose 얻기
	 *
	 * @return the poClose
	 */
	public String getPoClose() {
		return poClose;
	}

	/**
	 * poClose 설정
	 *
	 * @param poClose the poClose to set
	 */
	public void setPoClose(String poClose) {
		this.poClose = poClose;
	}

	/**
	 * poCancel 얻기
	 *
	 * @return the poCancel
	 */
	public String getPoCancl() {
		return poCancl;
	}

	/**
	 * poCancel 설정
	 *
	 * @param poCancel the poCancel to set
	 */
	public void setPoCancl(String poCancl) {
		this.poCancl = poCancl;
	}

	/**
	 * slipYn 얻기
	 *
	 * @return the slipYn
	 */
	public String getSlipYn() {
		return slipYn;
	}

	/**
	 * slipYn 설정
	 *
	 * @param slipYn the slipYn to set
	 */
	public void setSlipYn(String slipYn) {
		this.slipYn = slipYn;
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
	 * ioNo 얻기
	 *
	 * @return the ioNo
	 */
	public String getIoNo() {
		return ioNo;
	}

	/**
	 * ioNo 설정
	 *
	 * @param ioNo the ioNo to set
	 */
	public void setIoNo(String ioNo) {
		this.ioNo = ioNo;
	}

	/**
	 * accCd 얻기
	 *
	 * @return the accCd
	 */
	public String getAccCd() {
		return accCd;
	}

	/**
	 * accCd 설정
	 *
	 * @param accCd the accCd to set
	 */
	public void setAccCd(String accCd) {
		this.accCd = accCd;
	}

	/**
	 * qty 얻기
	 *
	 * @return the qty
	 */
	public BigDecimal getQty() {
		return qty;
	}

	/**
	 * qty 설정
	 *
	 * @param qty the qty to set
	 */
	public void setQty(BigDecimal qty) {
		this.qty = qty;
	}

	/**
	 * unit 얻기
	 *
	 * @return the unit
	 */
	public String getUnit() {
		return unit;
	}

	/**
	 * unit 설정
	 *
	 * @param unit the unit to set
	 */
	public void setUnit(String unit) {
		this.unit = unit;
	}

	/**
	 * uPrice 얻기
	 *
	 * @return the uPrice
	 */
	public BigDecimal getUPrice() {
		return uPrice;
	}

	/**
	 * uPrice 설정
	 *
	 * @param uPrice the uPrice to set
	 */
	public void setUPrice(BigDecimal uPrice) {
		this.uPrice = uPrice;
	}

	/**
	 * amt 얻기
	 *
	 * @return the amt
	 */
	public BigDecimal getAmt() {
		return amt;
	}

	/**
	 * amt 설정
	 *
	 * @param amt the amt to set
	 */
	public void setAmt(BigDecimal amt) {
		this.amt = amt;
	}

	/**
	 * cur 얻기
	 *
	 * @return the cur
	 */
	public String getCur() {
		return cur;
	}

	/**
	 * cur 설정
	 *
	 * @param cur the cur to set
	 */
	public void setCur(String cur) {
		this.cur = cur;
	}

	/**
	 * regDt 얻기
	 *
	 * @return the regDt
	 */
	public String getRegDt() {
		return regDt;
	}

	/**
	 * regDt 설정
	 *
	 * @param regDt the regDt to set
	 */
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	/**
	 * grFDt 얻기
	 *
	 * @return the grFDt
	 */
	public String getGrFDt() {
		return grFDt;
	}

	/**
	 * grFDt 설정
	 *
	 * @param grFDt the grFDt to set
	 */
	public void setGrFDt(String grFDt) {
		this.grFDt = grFDt;
	}

	/**
	 * mvt 얻기
	 *
	 * @return the mvt
	 */
	public String getMvt() {
		return mvt;
	}

	/**
	 * mvt 설정
	 *
	 * @param mvt the mvt to set
	 */
	public void setMvt(String mvt) {
		this.mvt = mvt;
	}

	/**
	 * prNo 얻기
	 *
	 * @return the prNo
	 */
	public String getPrNo() {
		return prNo;
	}

	/**
	 * prNo 설정
	 *
	 * @param prNo the prNo to set
	 */
	public void setPrNo(String prNo) {
		this.prNo = prNo;
	}

	/**
	 * prLno 얻기
	 *
	 * @return the prLno
	 */
	public String getPrLno() {
		return prLno;
	}

	/**
	 * prLno 설정
	 *
	 * @param prLno the prLno to set
	 */
	public void setPrLno(String prLno) {
		this.prLno = prLno;
	}

	/**
	 * poNo 얻기
	 *
	 * @return the poNo
	 */
	public String getPoNo() {
		return poNo;
	}

	/**
	 * poNo 설정
	 *
	 * @param poNo the poNo to set
	 */
	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	/**
	 * poLno 얻기
	 *
	 * @return the poLno
	 */
	public String getPoLno() {
		return poLno;
	}

	/**
	 * poLno 설정
	 *
	 * @param poLno the poLno to set
	 */
	public void setPoLno(String poLno) {
		this.poLno = poLno;
	}

	/**
	 * logger 얻기
	 *
	 * @return the logger
	 */
	public Logger getLogger() {
		return logger;
	}

}
