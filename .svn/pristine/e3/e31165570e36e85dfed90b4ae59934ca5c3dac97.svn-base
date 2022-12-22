package com.hwfs.batch.guide.sample.dto;

import java.io.UnsupportedEncodingException;

/**
 * 배치 샘플 ANSI형태의 고정길이 파일 읽어 분리하는 DTO
 * @ClassName GtpaIdDTO.java
 * @Description GtpaIdDTO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 22.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public class GtpaIdDTO {

	/** 데이터 항목 */
	private String item1;
	private String item2;
	private String item3;
	private String item4;

	/**
	 * 생성자
	 */
	public GtpaIdDTO() {
	}

	/**
	 * item1 얻기
	 *
	 * @return the item1
	 */
	public String getItem1() {
		return item1;
	}

	/**
	 * item1 설정
	 *
	 * @param item1 the item1 to set
	 */
	public void setItem1(String item1) {
		this.item1 = item1;
		//System.out.println("*****item1=" + item1 + ";");
	}

	/**
	 * item2 얻기
	 *
	 * @return the item2
	 */
	public String getItem2() {
		return item2;
	}

	/**
	 * item2 설정
	 *
	 * @param item2 the item2 to set
	 */
	public void setItem2(String item2) {
		this.item2 = item2;
		//System.out.println("*****item2=" + item2 + ";");
	}

	/**
	 * item3 얻기
	 *
	 * @return the item3
	 */
	public String getItem3() {
		return item3;
	}

	/**
	 * item3 설정
	 *
	 * @param item3 the item3 to set
	 */
	public void setItem3(String item3) {
		this.item3 = item3;
		//System.out.println("*****item3=" + item3 + ";");
	}

	/**
	 * item4 얻기
	 *
	 * @return the item4
	 */
	public String getItem4() {
		return item4;
	}

	/**
	 * item4 설정
	 *
	 * @param item4 the item4 to set
	 */
	public void setItem4(String item4) {
		this.item4 = item4;
		//System.out.println("*****item4=" + item4 + ";");
	}

	/**
	 * 고정길이 항목을 하나의 문자열로 합친다.
	 * @return 문자열
	 * @throws UnsupportedEncodingException
	 */
	public String getAllItems () throws UnsupportedEncodingException {
		//"fieldRanges" value="14,13,60,66"
		byte[] bytItem1 = new byte[14];
		byte[] bytItem2 = new byte[13];
		byte[] bytItem3 = new byte[60];
		byte[] bytItem4 = new byte[66];
		
		String strCharSet = "MS949";
		
		byte[] tmp = this.item1.getBytes(strCharSet);
		bytItem1 = copyBytes (tmp, bytItem1);
		tmp = this.item2.getBytes(strCharSet);
		bytItem2 = copyBytes (tmp, bytItem2);
		tmp = this.item3.getBytes(strCharSet);
		bytItem3 = copyBytes (tmp, bytItem3);
		tmp = this.item4.getBytes(strCharSet);
		bytItem4 = copyBytes (tmp, bytItem4);
		
		String strAllItems = new String(bytItem1, strCharSet)
						   + new String(bytItem2, strCharSet) 
						   + new String(bytItem3, strCharSet)
						   + new String(bytItem4, strCharSet);
		//System.out.println("*****=" + strAllItems);
		return strAllItems;
	}
	
	/**
	 * 바이트 원본 배열을 목적지 배열에 복사하고 뒷 부분은 스페이스로 채운다.  
	 * @param bytSrc
	 * @param bytTarget
	 * @return
	 */
	private static byte[] copyBytes (byte[] bytSrc, byte[] bytTarget) {
		int i, j;
    	for (i = 0, j=0; i < bytSrc.length && j < bytTarget.length; i++, j++)
    		bytTarget[j] = bytSrc[i];
    	
    	for (; j < bytTarget.length; j++)
    		bytTarget[j] = 0x20;
    	
    	return bytTarget;
	}

}
