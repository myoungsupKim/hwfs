package com.hwfs.sc.cmn.service;

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
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dao.ExternalUpjangIFDAO;

 /**
 * ExternalUpjangIFServiceImpl에 대한 설명 작성
 * @ClassName ExternalUpjangIFServiceImpl.java
 * @Description ExternalUpjangIFServiceImpl Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2018. 5. 14.   김명섭        최초생성
 * </pre>
 * @author FC정보기획팀
 * @since 2018. 5. 14.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service
public class ExternalUpjangIFServiceImpl extends DefaultServiceImpl implements ExternalUpjangIFService {
	private final Logger logger = LoggerFactory.getLogger (this.getClass());
	
	@Resource(name="/sc/cmn/ExternalUpjangIFDAO")
	private ExternalUpjangIFDAO ExternalUpjangIFDAO;
	
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
	@CustomAnnotationDefinition(txId="IF_PNCWORLD_SALS_INFO",Description="피엔씨월드 순천만 외부POS매출 인터페이스용 Service")
	public JSONObject saveData(JSONObject txHeader, JSONObject txData,JSONObject txResult) throws Exception {
		
		JSONObject processResult = new JSONObject();
		JSONObject result = new JSONObject();
		int insRow = 0;
		int dupRow = 0;
		logger.debug("★★★★★★★★★★★★★★★★★★★ExternalUpjangIF★★★★★★★★★★★★★★★★★★★★★★★★");
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");
		logger.debug(" HEADER INFO : " + txHeader.toString());
		logger.debug(" DATA   INFO : " + txData.toString());
		logger.debug(" RESULT INFO : " + txResult.toString());
		logger.debug("★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★");

    	try
    	{

    		String txDiv = (String) txHeader.get("txDiv");
    		logger.debug(" txDiv INFO : " + txDiv);
    		
    		if(isNull(txDiv)){
    			logger.error("txDiv is empty!");
    			processResult.put("ErrorCode", -1);
    			processResult.put("ErrorMsg", "txDiv는 필수 입니다.");
    			result.put("data", processResult);
    			return result;
    		}
    		
    		//매출데이터저장
    		if("INSERTDATA".equals(txDiv)){
    			
    			JSONArray datas = txData.getJSONArray("datas"); //KEY로 사용한 datas는 약속된 KEY로써 변경하지 마세요.
    			logger.debug("Data 체크 Start!!");
    			logger.debug("datas.length() : " + datas.length());
    			for (int i=0 ; i < datas.length() ; i++) {
    				logger.debug("i : " + i);
    				if(isNull(datas.getJSONObject(i).getString("outlet_cd"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "업장코드는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(isNull(datas.getJSONObject(i).getString("saldate"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "매출일자는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(isNull(datas.getJSONObject(i).getString("posno"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "POS번호는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(isNull(datas.getJSONObject(i).getString("trxnno"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "거래번호는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(isNull(datas.getJSONObject(i).getString("receiptno"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "영수증번호는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(isNull(datas.getJSONObject(i).getString("seqno"))){
    					processResult.put("ErrorCode", -2);
    					processResult.put("ErrorMsg", "시퀀스번호는 필수 입니다.");
    					result.put("data", processResult);
    					return result;
    				}
    				if(!isDate(datas.getJSONObject(i).getString("saldate"))){
    					processResult.put("ErrorCode", -3);
    					processResult.put("ErrorMsg", "매출일자 날짜형식이 바르지 않습니다.(YYYYMMDD)");
    					result.put("data", processResult);
    					return result;
    				}			
    				if(isUpjang(datas.getJSONObject(i).getString("outlet_cd"))){
    					processResult.put("ErrorCode", -3);
    					processResult.put("ErrorMsg", "등록되지 않은 사업장 코드 입니다.( "+datas.getJSONObject(i).getString("outlet_cd")+" )");		
    					result.put("data", processResult);
    					return result;
    				}			
    				
    			}
    			logger.debug("Data 체크 End!!");
    			for (int i=0 ; i < datas.length() ; i++) {
    				Map<String, Object> rowData = new HashMap<String, Object>();		
    				logger.debug("시작 : " + i);
    				rowData.put("outlet_cd", chkIsNull(datas,i,"outlet_cd"));//    --업장코드   
    		        rowData.put("saldate", chkIsNull(datas,i,"saldate"));//   --매출일자  
    		        rowData.put("posno", chkIsNull(datas,i,"posno"));//    --POS번호 
    		        rowData.put("trxnno", chkIsNull(datas,i,"trxnno"));//  --거래번호
    		        rowData.put("receiptno", chkIsNull(datas,i,"receiptno"));//   --영수증번호
    		        rowData.put("seqno", chkIsNull(datas,i,"seqno"));//  --시퀀스번호
    		        rowData.put("cancflg", chkIsNull(datas,i,"cancflg"));//   --매출구분(0:정상, 1:취소)
    		        rowData.put("saltime", chkIsNull(datas,i,"saltime"));//   --거래시간
    		        rowData.put("area_nm", chkIsNull(datas,i,"area_nm"));//   --영업장
    		        rowData.put("menu_grp", chkIsNull(datas,i,"menu_grp"));// --메뉴그룹
    		        rowData.put("menu_nm", chkIsNull(datas,i,"menu_nm"));//   --메뉴명
    		        rowData.put("menu_gb", chkIsNull(datas,i,"menu_gb"));//   --메뉴구분
    		        rowData.put("qty", chkIsNull(datas,i,"qty"));//    --수량
    		        rowData.put("price", chkIsNull(datas,i,"price"));//  --단가
    		        rowData.put("totamt", chkIsNull(datas,i,"totamt"));//   --총매출
    		        rowData.put("vatamt", chkIsNull(datas,i,"vatamt"));//   --부가세
    		        rowData.put("netamt", chkIsNull(datas,i,"netamt"));// --순매출
    		        rowData.put("discamt", chkIsNull(datas,i,"discamt"));//   --할인액
    		        rowData.put("disc_nm", chkIsNull(datas,i,"disc_nm"));//   --할인명
    		        rowData.put("cashamt", chkIsNull(datas,i,"cashamt"));//  --현금금액
    		        rowData.put("cardamt", chkIsNull(datas,i,"cardamt"));//   --카드금액
    		        rowData.put("etcamt", chkIsNull(datas,i,"etcamt"));//  --기타금액
    		        if(isDupData(rowData)){
    		        	dupRow += 1;
    		    		logger.debug("중복");
    		        }else{
    		    		logger.debug("입력");
    					insRow += ExternalUpjangIFDAO.insert(rowData);
    		        }
    			}
    			
    		} //if("INSERTDATA".equals(txDiv))

    		logger.debug("insert 종료");
    		//전달하고자하는 메시지등을 기술한다.
    		processResult.put("procCount", insRow);
    		processResult.put("dupCount", dupRow);
    		
    	}
    	catch (Exception e)
    	{
    		logger.error("에러 " +  e.getStackTrace());
    		logger.error("에러 MSG " +  e.getMessage());
    		//전달하고자하는 메시지등을 기술한다.
    		processResult.put("ErrorCode", -9);
    		processResult.put("ErrorMsg", "저장 중 오류가 발생했습니다.");
    	}
		
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
		int upjang = ExternalUpjangIFDAO.upjang(rowData);
		logger.debug("upjang" + upjang);
		if(upjang <= 0)return true;
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

	/**
	 * 중복데이터체크
	 *
	 * @param data
	 * @return
	 */
	public boolean isDupData(Map rowData) throws Exception{
		int dupcnt = ExternalUpjangIFDAO.dupcnt(rowData);
		logger.debug("dupcnt:" + dupcnt);
		if(dupcnt > 0)return true;
		return false;
	}
	
}
