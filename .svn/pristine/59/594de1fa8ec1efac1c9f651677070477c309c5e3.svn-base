package com.hwfs.ei.cmn;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.Format;
import org.jdom2.output.XMLOutputter;

 /**
 * ReceiptXML에 대한 설명 작성
 * @ClassName ReceiptXML.java
 * @Description ReceiptXML Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 12. 23.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 12. 23.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class IrisReceiptXML {
	private Element Document = new Element("document");
	private Element Transaction = new Element("Transaction");
	private Element TranInformation = new Element("TranInformation");
	private Element TranNode = new Element("TranNode");
	private Element ItemList = new Element("ItemList");
	private Element ItemNode;
	private Element TenderList = new Element("TenderList");
	private Element TenderNode;
	private Element TypeTenderNode;
	
	private Element Journal = new Element("Journal");
	
	public String getXmlString(String encoding) {
		Document doc = new Document();
		doc.setRootElement(this.getDocument());
		
		XMLOutputter outputter = new XMLOutputter(Format.getPrettyFormat().setEncoding(encoding));
		
		return outputter.outputString(doc);
	}
	
	/**
	 * XML Document 가져온다.
	 *
	 * @return
	 */
	public Element getDocument() {
		return this.Document;
	}
	
	/**
	 * XML Document에 Transaction Element를 추가한다.
	 *
	 */
	public void setDocument() {
		this.Document.addContent(this.Transaction);
	}
	
	/**
	 * Transaction Element에 TranInformation Element와 TranNode를 추가한다.
	 *
	 */
	public void setTransaction() {
		this.Transaction.addContent(this.TranInformation);
		this.Transaction.addContent(this.TranNode);
		this.Journal.setAttribute("type", "printer");
		this.Transaction.addContent(this.Journal);
	}
	
	/**
	 * TranInformation에 각 Node Element를 추가한다.
	 *
	 * @param key
	 * @param text
	 */
	public void setTranInformation(String key, String text) {
		Element e = new Element(key);
		e.setText(text);

		this.TranInformation.addContent(e);
	}
	
	/**
	 * 판매구분(N:정상, R:반품, I:내부이용정상, V:내부이용반품)
	 *
	 * @param text
	 */
	public void setTranFlag(String text) {
		Element e = new Element("TranFlag");
		e.setText(text);
		
		this.TranNode.addContent(e);
	}
	
	public void setTranNode() {
		this.TranNode.addContent(this.ItemList);
		this.TranNode.addContent(this.TenderList);
		
		Element e = new Element("OtherList");
		this.TranNode.addContent(e);
		
		e = new Element("PartnerList");
		this.TranNode.addContent(e);
		
		e = new Element("CUST_DIV");
		this.TranNode.addContent(e);
		
		e = new Element("CUST_CODE");
		this.TranNode.addContent(e);
		
		e = new Element("CC_ID_NO");
		this.TranNode.addContent(e);
		
		e = new Element("GROUP_EVNT_CODE");
		this.TranNode.addContent(e);
		
		e = new Element("AUTO_SALE_EQMT_CODE");
		this.TranNode.addContent(e);
		
		e = new Element("CUST_ZONE");
		this.TranNode.addContent(e);
		
		e = new Element("BUNDLE_CUST_CONT");
		e.setText("0");
		this.TranNode.addContent(e);
		
		e = new Element("HALL_TABLE_NO");
		this.TranNode.addContent(e);
		
		e = new Element("REASON_CODE");
		this.TranNode.addContent(e);
		
		e = new Element("PRE_RECEIPT_NO");
		this.TranNode.addContent(e);
		
		e = new Element("TRAN_MEMO");
		this.TranNode.addContent(e);
	}
	
	public void setItemList() {
		this.ItemList.addContent(this.ItemNode);
	}
	
	public void addItemNode() {
		this.ItemNode = new Element("ItemNode");
		
		Element e = new Element("ItemFlag");
		e.setText("정정");
		this.ItemNode.addContent(e);
		
		e = new Element("CadyYn");
		e.setText("0");
		this.ItemNode.addContent(e);
		
		e = new Element("BottleCode");
		this.ItemNode.addContent(e);
		
		e = new Element("BOTL_MNGM_YN");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("BOTL_YN");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("SubDiscountAmount");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("SubDiscountQty");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("PretendQty");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("EventFlag");
		e.setText("false");
		this.ItemNode.addContent(e);

		e = new Element("ServiceAmt");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("ServiceRate");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("WEIG_YN");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("PointType");
		this.ItemNode.addContent(e);

		e = new Element("PointQty");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("PointDcAmt");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("PointArAmt");
		e.setText("0");
		this.ItemNode.addContent(e);

		e = new Element("PointTrack2");
		this.ItemNode.addContent(e);

		e = new Element("PointApprDate");
		this.ItemNode.addContent(e);

		e = new Element("PointApprNo");
		this.ItemNode.addContent(e);
	}
	
	public void setItemNode(String key, String text) {
		Element e = new Element(key);
		e.setText(text);
		
		this.ItemNode.addContent(e);
	}
	
	public void createTypeTenderNode(String key) {
		this.TypeTenderNode = new Element(key);
	}
	
	public void setTyepTenderNode(String key, String text) {
		Element e = new Element(key);
		e.setText(text);
		
		this.TypeTenderNode.addContent(e);
	}
	
	public void setTyepTenderNode() {
		this.TypeTenderNode.addContent(this.TenderNode);
	}
	
	public void addTenderNode() {
		this.TenderNode = new Element("TenderNode");
	}
	
	public void setTenderNode(String key, String text) {
		Element e = new Element(key);
		e.setText(text);
		
		this.TenderNode.addContent(e);
	}
	
	public void setTenderList() {
		this.TenderList.addContent(this.TypeTenderNode);
	}
	
	public void setJournal(String attr, String text) {
		Element e = new Element("string");
		e.setAttribute("type", attr);
		e.setText(text);
		
		this.Journal.addContent(e);
	}
}
