package com.hwfs.sm.spm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.cmn.dao.AdvanceCommonDAO;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.CardApprvPopupDAO;
import com.hwfs.sm.spm.dao.AdvanceOccurInquiryPopDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;

import com.tobesoft.xplatform.data.DataSet;

 /**
 * 선수금발생조회팝업하는 AdvanceOccurInquiryPop Service Implementation
 * 
 * @ClassName AdvanceOccurInquiryPopServiceImpl.java
 * @Description AdvanceOccurInquiryPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.04    유성진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유성진
 * @since 2015.08.04
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/spm/advanceOccurInquiryPopService")
public class AdvanceOccurInquiryPopServiceImpl extends DefaultServiceImpl implements AdvanceOccurInquiryPopService {
	
	/** AdvanceOccurInquiryPopDAO Bean 생성 */
	@Resource(name = "/sm/spm/advanceOccurInquiryPopDAO")
	private AdvanceOccurInquiryPopDAO advanceOccurInquiryPopDAO;
	
	/** AdvanceCommonDAO Bean 생성 */
	@Resource(name = "/sm/cmn/advanceCommonDAO")
	private AdvanceCommonDAO advanceCommonDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;
	
	/** CardApprvPopupDAO Bean 생성 */
	@Resource(name = "/sm/sar/cardApprvPopupDAO")
	private CardApprvPopupDAO cardApprvPopupDAO;
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;
	

	/**
	 * 선수금발생조회팝업 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return advanceOccurInquiryPopDAO.selectList(mapParam);
	}

	/**
	 * 선수금발생조회팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap inData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0; 
		
		String maxAdvanceNum = "";
		String maxArNum      = "";
		
		if(inData.get(0).get("advanceNum").equals("0") || inData.get(0).get("advanceNum").equals("")){
			
			//선수금마스터 채번 MAX값
			maxAdvanceNum = advanceCommonDAO.getMaxAdvanceNum(inData.get(0));
			//선수금 등록
			Map<String, Object> rowAddData = inData.get(0);		//선수금 저장
			
			rowAddData.put("seq", "1");			                                    //지불테이블에 순번
			//rowAddData.put("sysClass", "13");                                       //시스템구분 (식자재)
			rowAddData.put("occurDate", rowAddData.get("procDate"));                //발생일자
			rowAddData.put("fiscalDate", rowAddData.get("procDate"));               //회계일자
			
			//채권마스터 채권번호 MAX값 가져오기
			maxArNum      = arMstProcessDAO.selectMaxArNum(rowAddData);
			rowAddData.put("arNum", maxArNum);
			rowAddData.put("arTypeCd", "F11");        //미수금신용카드

			
			rowAddData.put("journalzYn", "N");                                      //분개여부
			//선수금마스터발생관련 데이타
			rowAddData.put("occurAmt", rowAddData.get("adjustAmt"));                //발생금액
			rowAddData.put("advanceNum", maxAdvanceNum);                            //선수금번호
			rowAddData.put("maxAdvanceNum", maxAdvanceNum);                         //선수금번호  선수금마스터에는 maxAdvanceNum 으로 들어감
			rowAddData.put("advanceOccurClass", "AO09");                            //선수금발생구분  식재선수금 발생
			rowAddData.put("advanceTypeCd", "F11");                                 //선수금유형코드  일반선수금FS

			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapDataAdd = new HashMap<String,Object>();
			
			mapDataAdd.put("typeGrpCdDtl", "006");
			mapDataAdd.put("typeCd", rowAddData.get("arTypeCd"));
			RecordSet rsAd = salesTypeMgntDAO.selectDtlList(mapDataAdd);
			
			for (int i = 0; i < rsAd.size(); i++){
				mapDataAdd.put("acctCd", rsAd.get(i).get("acctCd"));
			}
			
			rowAddData.put("acctCd", mapDataAdd.get("acctCd"));           //계정코드 셋팅 선수금 선매출
			rowAddData.put("occurSupplyAmt", rowAddData.get("adjustAmt"));                                    //발생공급가액
			rowAddData.put("occurVatAmt", 0);                                       //발생부가세
			rowAddData.put("vatCd", "X");                                           //부가세구분  안들어감
			//선수금마스터 발생
			insRowCnt += advanceCommonDAO.insertAdvanceMaster(rowAddData);
			
			
			//선수금입금수단 발생
			rowAddData.put("settleClass", "2");                            //결제구분 2:신용카드
			insRowCnt += advanceCommonDAO.insertOriAdvanceReceiveWay(rowAddData);

			
			//마스터 처리
			Map<String, Object> rowArData = inData.get(0);		//채권
			
			rowArData.put("seq", "1");			                                    //지불테이블에 순번
			//rowAddData.put("sysClass", "13");                                       //시스템구분 (식자재)
			rowArData.put("occurDate", rowArData.get("procDate"));                //발생일자
			rowArData.put("fiscalDate", rowArData.get("procDate"));               //회계일자
			rowArData.put("journalzYn", "N");                                      //분개여부
			
			rowArData.put("arNum", maxArNum);
			rowArData.put("arOccurClass", "AO01");   //채권발생구분  : 신용카드청구
			rowArData.put("arTypeCd", "A03");        //미수금신용카드
			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapData = new HashMap<String,Object>();
			
			mapData.put("typeGrpCdDtl", "001");
			mapData.put("typeCd", rowArData.get("arTypeCd"));
			RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
			
			for (int i = 0; i < rs.size(); i++){
				mapData.put("acctCd", rs.get(i).get("acctCd"));
			}
			rowArData.put("acctCd", mapData.get("acctCd"));           //계정코드 셋팅  미수금_신용카드_청구(-)
			rowArData.put("arAmt", rowArData.get("adjustAmt"));      //채권금액
			rowArData.put("custCd", rowArData.get("cardCustCd"));      //채권금액
			rowArData.put("custNm", rowArData.get("cardCustNm"));      //채권금액
			rowArData.put("taxShetPublishYn", "N");                   //세금계산서 발행 여부
			rowArData.put("payClassCd", "2");                         //지불 구분 코드
			rowArData.put("billingPublishYn", "N");                   //청구 발행 여부
			
			//채권발생
			insRowCnt += arMstProcessDAO.insert(rowArData);
			
			//카드승인정보 발생
			rowArData.put("ediInputClass", "3");                          //선수금
			rowArData.put("cardProcType", "2");                           //카드처리유형  2:선수금입금
			rowArData.put("cardComCd", rowArData.get("buycpnyCd"));      //카드사코드
			rowArData.put("cardNum", rowArData.get("creditCardNum"));    //카드번호
			rowArData.put("apprvDate", rowArData.get("procDate"));       //승인일자
			rowArData.put("useAmt", rowArData.get("adjustAmt"));         //승인금액
			
			insRowCnt += cardApprvPopupDAO.insert(rowArData); 

		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 선수금발생조회팝업 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int cancelList(DataSetMap inData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0; 
						
		//마스터 처리
		Map<String, Object> rowAddData = inData.get(0);
		
		//선수금마스터 삭제
		delRowCnt += advanceCommonDAO.mstAdvanceCancel(rowAddData);
		
		//선수금입금수단 삭제
		delRowCnt += advanceCommonDAO.advanceReceiveWayCancel(rowAddData);
		
		//채권정보 삭제
		delRowCnt += arMstProcessDAO.cancelArMst(rowAddData);
		
		//카드승인정보 삭제
		delRowCnt += cardApprvPopupDAO.cardApprvInfoCancel(rowAddData);
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
