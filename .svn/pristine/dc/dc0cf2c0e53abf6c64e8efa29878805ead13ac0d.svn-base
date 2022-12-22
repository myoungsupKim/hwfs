package com.hwfs.fs.fsl.service;

import hone.hanwha.CustomAnnotaion.CustomAnnotationDefinition;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsl.dao.FslIfVendingDAO;

 /**
 * FslIfVendingServiceImpl에 대한 설명 작성
 * @ClassName FslIfVendingServiceImpl.java
 * @Description FslIfVendingServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 8. 24.   이지운        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 taiho
 * @since 2015. 7. 30.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class FslIfVendingServiceImpl extends DefaultServiceImpl implements FslIfVendingService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/fs/fsl/fslIfVendingDAO")
	private FslIfVendingDAO fslIfVendingDAO;
	
	/**
	 * saveData 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param txHeader
	 * @param txData
	 * @param txResult
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.FslIfVendingService#saveData(org.json.JSONObject, org.json.JSONObject, org.json.JSONObject)
	*/
	@SuppressWarnings("unchecked")
	@CustomAnnotationDefinition(txId="FslIfVending",Description="식권자판기 인터페이스용 Service")
	public JSONObject saveData(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
		JSONObject processResult = new JSONObject();
		JSONObject result = new JSONObject();
		int insRow = 0;
		logger.debug("★★★★★★★★★★★★★★★★★★★FslIfVending★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		logger.debug(" HEADER INFO : " + txHeader.toString());
		logger.debug(" DATA   INFO : " + txData.toString());
		logger.debug(" RESULT INFO : " + txResult.toString());
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		
		JSONArray datas = txData.getJSONArray("datas"); //KEY로 사용한 datas는 약속된 KEY로써 변경하지 마세요.
		logger.debug("Data 체크 Start!!");
		logger.debug("datas.length() : " + datas.length());
		for (int i=0 ; i < datas.length() ; i++) {
			logger.debug("i : " + i);
			if(isNull(datas.getJSONObject(i).getString("occurDate"))){
				logger.debug("occurDate : " + datas.getJSONObject(i).getString("occurDate"));
				processResult.put("ErrorCode", -2);
				processResult.put("ErrorMsg", "매출 발생일자는 필수 입니다.");
				result.put("data", processResult);
				return result;
			}
			if(!isDate(datas.getJSONObject(i).getString("occurDate"))){
				logger.debug("occurDate : " + datas.getJSONObject(i).getString("occurDate"));
				processResult.put("ErrorCode", -2);
				processResult.put("ErrorMsg", "매출 발생일자 날짜형식이 올바르지 않습니다.(YYYYMMDD)");
				result.put("data", processResult);
				return result;
			}			
			if(isNull(datas.getJSONObject(i).getString("saleDate"))){
				processResult.put("ErrorCode", -2);
				processResult.put("ErrorMsg", "매출 판매일자는 필수 입니다.");
				result.put("data", processResult);
				return result;
			}
			if(!isDate(datas.getJSONObject(i).getString("saleDate"))){
				processResult.put("ErrorCode", -2);
				processResult.put("ErrorMsg", "매출 판매일자 날짜형식이 올바르지 않습니다.(YYYYMMDD)");
				result.put("data", processResult);
				return result;
			}				
			if(isNull(datas.getJSONObject(i).getString("upjangCd"))){
				processResult.put("ErrorCode", -3);
				processResult.put("ErrorMsg", "업장코드는 필수 입니다.");		
				result.put("data", processResult);
				return result;
			}
			if(isUpjang(datas.getJSONObject(i).getString("upjangCd"))){
				processResult.put("ErrorCode", -3);
				processResult.put("ErrorMsg", "등록되지 않은 사업장 코드 입니다.( "+datas.getJSONObject(i).getString("upjangCd")+" )");		
				result.put("data", processResult);
				return result;
			}			
			if(isNull(datas.getJSONObject(i).getString("custCd"))){
				processResult.put("ErrorCode", -4);
				processResult.put("ErrorMsg", "거래처 코드는 필수 입니다.");	
				result.put("data", processResult);
				return result;
			}
			if(isCust(datas.getJSONObject(i).getString("custCd"),datas.getJSONObject(i).getString("upjangCd"))){
				processResult.put("ErrorCode", -4);
				processResult.put("ErrorMsg", "등록되지 않은 거래처 코드 입니다.( "+datas.getJSONObject(i).getString("custCd")+" )");	
				result.put("data", processResult);
				return result;
			}
			if(isNull(datas.getJSONObject(i).getString("vatClass"))){
				processResult.put("ErrorCode", -5);
				processResult.put("ErrorMsg", "부가세 종류는 필수 입니다.");			
				result.put("data", processResult);
				return result;
			}
			if(isVat(datas.getJSONObject(i).getString("vatClass"))){
				processResult.put("ErrorCode", -5);
				processResult.put("ErrorMsg", "알 수 없는 부가세 코드입니다.( " +datas.getJSONObject(i).getString("vatClass")+ " )");
				result.put("data", processResult);
				return result;
			}			
			if(isNull(datas.getJSONObject(i).getString("payCd"))){
				processResult.put("ErrorCode", -6);
				processResult.put("ErrorMsg", "지불 코드는 필수 입니다.");			
				result.put("data", processResult);
				return result;
			}
			if(isPay(datas.getJSONObject(i).getString("payCd"))){
				processResult.put("ErrorCode", -6);
				processResult.put("ErrorMsg", "알 수 없는 지불코드입니다.( " +datas.getJSONObject(i).getString("payCd")+ " )");	
				result.put("data", processResult);
				return result;
			}
			if(isNull(datas.getJSONObject(i).getString("taxShetPublishYn"))){
				processResult.put("ErrorCode", -7);
				processResult.put("ErrorMsg", "세금계산서 발행 여부는 필수 입니다.");	
				result.put("data", processResult);
				return result;
			}
			
			logger.debug("payCd : " + datas.getJSONObject(i).getString("payCd"));
			logger.debug("isCard : " + isCard(datas.getJSONObject(i).getString("payCd")));
			
			if(isCard(datas.getJSONObject(i).getString("payCd")))
			{
				logger.debug("cardComCd : " + datas.getJSONObject(i).getString("cardComCd"));
				logger.debug("frncStorNum : " + datas.getJSONObject(i).getString("frncStorNum"));
				if(isNull(datas.getJSONObject(i).getString("cardComCd"))){
					processResult.put("ErrorCode", -8);
					processResult.put("ErrorMsg", "지불수단이 카드일 경우 카드사코드는 필수입니다.(cardComCd)" );
					result.put("data", processResult);
					return result;
				}
				if(isNull(datas.getJSONObject(i).getString("frncStorNum"))){
					processResult.put("ErrorCode", -9);
					processResult.put("ErrorMsg", "지불수단이 카드일 경우 가맹점 번호는 필수 입니다.(frncStorNum)");
					result.put("data", processResult);
					return result;
				}
			}
			/*
			if(isNull(datas.getJSONObject(i).getString("itemCd"))){
				processResult.put("ErrorCode", -2);
				processResult.put("ErrorMsg", "자재코드는 필수 입니다.");
				result.put("data", processResult);
				return result;
			}
			*/
		}
		logger.debug("Data 체크 End!!");
		for (int i=0 ; i < datas.length() ; i++) {
			Map<String, Object> rowData = new HashMap<String, Object>();		
			logger.debug("시작 : " + i);
			rowData.put("occurDate", chkIsNull(datas,i,"occurDate"));//    --매출 발생일자   
	        rowData.put("saleDate", chkIsNull(datas,i,"saleDate"));//   --매출 판매일자  
	        rowData.put("upjangCd", chkIsNull(datas,i,"upjangCd"));//    --업장 코드 
	        rowData.put("custCd", chkIsNull(datas,i,"custCd"));//  --거래처코드
	        rowData.put("kindType", chkIsNull(datas,i,"kindType"));//
	        rowData.put("posNum", chkIsNull(datas,i,"posNum"));//  --POS 번호 or 창고번호
	        rowData.put("itemCd", chkIsNull(datas,i,"itemCd"));//
	        rowData.put("modifySalsYn", chkIsNull(datas,i,"modifySalsYn"));//   --데이터구분(N정상 / Y조정분)
	        rowData.put("vatClass", chkIsNull(datas,i,"vatClass"));//   --부과세 종류(43. 면세매출_기타 / 20. 과세매출_기타 / 21. 영세매출_기타)
	        rowData.put("payCd", chkIsNull(datas,i,"payCd"));// --"지불 코드(1현금2카드4쿠폰5타점마감6타사상품권7후불(외상)P1선수금P2선수금(식권)Z내부이용9가수금(CMS))"
	        rowData.put("advanceClass", chkIsNull(datas,i,"advanceClass"));//
	        rowData.put("bldType", chkIsNull(datas,i,"bldType"));//   --"조중석 구분 1: 조식2: 중식3: 석식4: 간식5: 야식6: 종일식* 외식은 조중석만"
	        rowData.put("salQuantity", chkIsNull(datas,i,"salQuantity"));//    --판매 수량
	        rowData.put("uprice", chkIsNull(datas,i,"uprice"));//  --단가
	        rowData.put("salAmt", chkIsNull(datas,i,"salAmt"));//   --금액
	        rowData.put("taxShetPublishYn", chkIsNull(datas,i,"taxShetPublishYn"));//   --세금계산서 발행 여부
	        rowData.put("evidence1", chkIsNull(datas,i,"evidence1"));// --증빙 1
	        rowData.put("evidence2", chkIsNull(datas,i,"evidence2"));//   --"증빙 2
	        rowData.put("evidence3", chkIsNull(datas,i,"evidence3"));//   --"증빙 3 - 지불코드별로 아래와 같이 처리2카드 : 승인번호4쿠폰 : 쿠폰번호Z내부이용 : 법인카드(xxxx-xx**-****-**xx)"
	        rowData.put("evidence5", chkIsNull(datas,i,"evidence5"));//  --"증빙 5 - 지불코드별로 아래와 같이 처리  2카드 : 매입사의 거래처 코드  6타사상품권 : 거래처코드"
	        rowData.put("cardClass", chkIsNull(datas,i,"cardClass"));//   --"카드 구분1: 신용카드2: 체크카드"
	        rowData.put("cardComCd", chkIsNull(datas,i,"cardComCd"));//  --카드사 코드
	        rowData.put("frncStorNum", chkIsNull(datas,i,"frncStorNum"));//  --가맹점 번호
	        rowData.put("receiptNum", chkIsNull(datas,i,"receiptNum"));//
	        rowData.put("seq", chkIsNull(datas,i,"seq"));//
	        rowData.put("jobStatus", chkIsNull(datas,i,"jobStatus"));//
	        rowData.put("cdate", chkIsNull(datas,i,"cdate"));//--SYSDATE        생성일
	        rowData.put("cuser", chkIsNull(datas,i,"cuser"));//  --생성자
	        rowData.put("udate", chkIsNull(datas,i,"udate"));//  --SYSDATE        수정일
	        rowData.put("uuser", chkIsNull(datas,i,"uuser"));//   --수정자
			insRow += fslIfVendingDAO.insert(rowData);
		}
		logger.debug("insert 종료");
		//식권발급기 쪽으로 전달하고자하는 메시지등을 기술한다.
		processResult.put("procCount", insRow);
		
		result.put("data", processResult);
		
		return result;
	}
	
	/**
	 * 데이터 널 여부 체크
	 * isNull 기능 설명
	 *
	 * @param data
	 * @return
	 */
	public boolean isNull(String data){
		if(data == null || data.equals("")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 데이터의 길이 체크
	 * isLength 기능 설명
	 *
	 * @param data
	 * @param lengthSize
	 * @return
	 */
	public boolean isLength(String data, int lengthSize){
		if(data.length() > lengthSize)return true;
		return false;
	}
	
	/**
	 * 데이터의 날짜 길이 체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDate(String data){
		if(data.length() == 8)return true;
		return false;
	}
	
	/**
	 * 사업장 SCO_UPJANG_V 에 등록여부 체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isUpjang(String data) throws Exception{
		Map<String, Object> rowData = new HashMap<String, Object>();
		rowData.put("upjang", data);
		int upjang = fslIfVendingDAO.upjang(rowData);
		logger.debug("upjang" + upjang);
		if(upjang <= 0)return true;
		return false;
	}
	
	/**
	 * 고객사 SCO_UPJANG_CUST 에 등록여부 체크
	 * isLength 기능 설명
	 *
	 * @param data
	 * @return
	 */
	public boolean isCust(String cust, String upjang) throws Exception{
		Map<String, Object> rowData = new HashMap<String, Object>();
		rowData.put("custcd", cust);
		rowData.put("upjang", upjang);
		int custcd = fslIfVendingDAO.cust(rowData);
		logger.debug("custcd : " + custcd);
		if(custcd <= 0)return true;
		return false;
	}
	
	/**
	 * 부가세 코드 체크
	 * 부과세 종류(43. 면세매출_기타 / 20. 과세매출_기타 / 21. 영세매출_기타)
	 *
	 * @param data
	 * @return
	 */
	public boolean isVat(String data) throws Exception{
		logger.debug("vat : " + data);
		if(data == "43" || data == "20" || data == "21") return true;
		return false;
	}
	
	/**
	 * 지불 코드 체크
	 * 지불 코드(1현금2카드4쿠폰5타점마감6타사상품권7후불(외상)P1선수금P2선수금(식권)Z내부이용9가수금(CMS))
	 *
	 * @param data
	 * @return
	 */
	public boolean isPay(String data) throws Exception{
		if(data == "1" || data == "2" || data == "4" || data == "5" || data == "6" || data == "7" || data.toUpperCase() == "P1" || data.toUpperCase() == "P2" || data.toUpperCase() == "Z") return true;
		return false;
	}

	/**
	 * 카드사/가맹점 체크
	 * 지불 코드(2카드) 일 경우 
	 *
	 * @param data
	 * @return
	 */	
	public boolean isCard(String data) throws Exception{
		if(data.equals("2")) return true;
		return false;
	}	
	
	public String chkIsNull(JSONArray datas,int row,String col) throws Exception{
		String data = "";
		try{
			data = datas.getJSONObject(row).getString(col);
		}catch(Exception e){
			return "";
		}
		return data;
	}

}
