package com.hwfs.sc.cmn.sap.dto;

import java.io.Serializable;
import java.math.BigDecimal;

import com.hwfs.cmn.defaults.DefaultDTO;

 /**
 * ElctnTaxShetItemDTO에 대한 설명 작성
 * @ClassName ElctnTaxShetItemDTO.java
 * @Description ElctnTaxShetItemDTO Class
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
public class ElctnTaxShetItemDTO extends DefaultDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String taxShetNum = "";
	private BigDecimal itemSeq = BigDecimal.ZERO;
	private String itemSupplyDate = "";
	private String itemNm = "";
	private String itemStand = "";
	private BigDecimal itemQuantity = BigDecimal.ZERO;
	private BigDecimal itemUprice = BigDecimal.ZERO;
	private BigDecimal itemSupplyAmt = BigDecimal.ZERO;
	private BigDecimal itemVatAmt = BigDecimal.ZERO;
	private String itemRemark = "";
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
	/**
	 * itemSeq 얻기
	 *
	 * @return the itemSeq
	 */
	public BigDecimal getItemSeq() {
		return itemSeq;
	}
	/**
	 * itemSeq 설정
	 *
	 * @param itemSeq the itemSeq to set
	 */
	public void setItemSeq(BigDecimal itemSeq) {
		this.itemSeq = itemSeq;
	}
	/**
	 * itemSupplyDate 얻기
	 *
	 * @return the itemSupplyDate
	 */
	public String getItemSupplyDate() {
		return itemSupplyDate;
	}
	/**
	 * itemSupplyDate 설정
	 *
	 * @param itemSupplyDate the itemSupplyDate to set
	 */
	public void setItemSupplyDate(String itemSupplyDate) {
		this.itemSupplyDate = itemSupplyDate;
	}
	/**
	 * itemNm 얻기
	 *
	 * @return the itemNm
	 */
	public String getItemNm() {
		return itemNm;
	}
	/**
	 * itemNm 설정
	 *
	 * @param itemNm the itemNm to set
	 */
	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	/**
	 * itemStand 얻기
	 *
	 * @return the itemStand
	 */
	public String getItemStand() {
		return itemStand;
	}
	/**
	 * itemStand 설정
	 *
	 * @param itemStand the itemStand to set
	 */
	public void setItemStand(String itemStand) {
		this.itemStand = itemStand;
	}
	/**
	 * itemQuantity 얻기
	 *
	 * @return the itemQuantity
	 */
	public BigDecimal getItemQuantity() {
		return itemQuantity;
	}
	/**
	 * itemQuantity 설정
	 *
	 * @param itemQuantity the itemQuantity to set
	 */
	public void setItemQuantity(BigDecimal itemQuantity) {
		this.itemQuantity = itemQuantity;
	}
	/**
	 * itemUprice 얻기
	 *
	 * @return the itemUprice
	 */
	public BigDecimal getItemUprice() {
		return itemUprice;
	}
	/**
	 * itemUprice 설정
	 *
	 * @param itemUprice the itemUprice to set
	 */
	public void setItemUprice(BigDecimal itemUprice) {
		this.itemUprice = itemUprice;
	}
	/**
	 * itemSupplyAmt 얻기
	 *
	 * @return the itemSupplyAmt
	 */
	public BigDecimal getItemSupplyAmt() {
		return itemSupplyAmt;
	}
	/**
	 * itemSupplyAmt 설정
	 *
	 * @param itemSupplyAmt the itemSupplyAmt to set
	 */
	public void setItemSupplyAmt(BigDecimal itemSupplyAmt) {
		this.itemSupplyAmt = itemSupplyAmt;
	}
	/**
	 * itemVatAmt 얻기
	 *
	 * @return the itemVatAmt
	 */
	public BigDecimal getItemVatAmt() {
		return itemVatAmt;
	}
	/**
	 * itemVatAmt 설정
	 *
	 * @param itemVatAmt the itemVatAmt to set
	 */
	public void setItemVatAmt(BigDecimal itemVatAmt) {
		this.itemVatAmt = itemVatAmt;
	}
	/**
	 * itemRemark 얻기
	 *
	 * @return the itemRemark
	 */
	public String getItemRemark() {
		return itemRemark;
	}
	/**
	 * itemRemark 설정
	 *
	 * @param itemRemark the itemRemark to set
	 */
	public void setItemRemark(String itemRemark) {
		this.itemRemark = itemRemark;
	}

}
