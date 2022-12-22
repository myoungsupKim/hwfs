package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;
import java.util.HashMap;
import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.GiftBillingPopDAO;
import com.hwfs.sm.sar.dao.ReceiveMgntPopDAO;
import com.hwfs.sm.ssi.dao.SalesTypeMgntDAO;

 /**
 * 상품권 청구처리하는 GiftBillingPop Service Implementation
 * 
 * @ClassName GiftBillingPopServiceImpl.java
 * @Description GiftBillingPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.09    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/giftBillingPopService")
public class GiftBillingPopServiceImpl extends DefaultServiceImpl implements GiftBillingPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** GiftBillingPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/giftBillingPopDAO")
	private GiftBillingPopDAO giftBillingPopDAO;
	
	/** 
	 * 채권 마스터 테이블에는 공통적인 요소들이 있어서 일단 따로 빼서 작업하고 추후 오라클 프로시져로 생성할려고 계획중임.
	 * ArMstProcessDAO Bean 생성
	 */
	
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;
	
	/** ReceiveMgntPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntPopDAO")
	private ReceiveMgntPopDAO receiveMgntPopDAO;
	
	/** SalesTypeMgntDAO Bean 생성 */
	@Resource(name = "/sm/ssi/salesTypeMgntDAO")
	private SalesTypeMgntDAO salesTypeMgntDAO;
	
	/**
	 * 상품권 청구처리 목록을 조회한다.
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
		return giftBillingPopDAO.selectList(mapParam);
	}

	/**
	 * 상품권 청구처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap inData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		String maxReceiveNum="";    //입금관리용 입금번호 생성
		//채권번호 생성(MAX값 조회)
		String maxArNum;
		String ccCdSch="";    //채권정보생성할 업장CC
		String ccCd="";       //상품권청구처리용 업장CC
		Map<String, Object> inValueData = inData.get(0);
		
		if(inValueData.get("giftBillingNum").toString().isEmpty()){
			maxArNum =  arMstProcessDAO.selectMaxArNum(inValueData);
			//입금처리 번호 생성(max값)
			inValueData.put("receiveDate", inValueData.get("occurDate"));
			maxReceiveNum =  receiveMgntPopDAO.selectMaxReceiveNum(inValueData);
			
			ccCdSch = (String) inValueData.get("ccCdSch");
			ccCd    = (String) inValueData.get("ccCd");
			/*데이터 셋팅*/
			inValueData.put("arNum", maxArNum);		//채권번호
			inValueData.put("fiscalDate", inValueData.get("occurDate"));		//회계일자
			inValueData.put("ccCd", ccCdSch);                //input업장CC   ccCd에 다시 셋팅
			inValueData.put("arOccurClass", "3");		//채권유형코드
			inValueData.put("arTypeCd", "A05");		    //채권유형코드
			inValueData.put("sysClass", list.getMapValue(0, "sysClass"));       //시스템구분
			//inValueData.put("acctCd", "11204020");      //미수금_타사상품권
			
			//영업유형 을(를) 조회한다.(계정코드 가져오자)
			Map<String,Object> mapData = new HashMap<String,Object>();
			
			mapData.put("typeGrpCdDtl", "001");
			mapData.put("typeCd", inValueData.get("arTypeCd"));
			RecordSet rs = salesTypeMgntDAO.selectDtlList(mapData);
			
			for (int i = 0; i < rs.size(); i++){
				mapData.put("acctCd", rs.get(i).get("acctCd"));
			}
						
			inValueData.put("acctCd", mapData.get("acctCd"));    //계정코드 셋팅
			
			inValueData.put("recdStatus", "L");		//레코드 상태
			
			insRowCnt += arMstProcessDAO.insert(inValueData);
			
			//상품권 청구번호 생성(MAX값 조회)
			String maxBillingNum;
			maxBillingNum =  giftBillingPopDAO.selectMaxBillingNum(inValueData);
			inValueData.put("giftBillingNum", maxBillingNum);
			inValueData.put("ccCd", ccCd);                //ccCd에 다시 셋팅
			insRowCnt += giftBillingPopDAO.insert(inValueData);
			
			//입금마스터 발생
			inValueData.put("receiveNum", maxReceiveNum);    //입금번호
			inValueData.put("receiveOccurClass", "RO05");    //입금발생구분
			inValueData.put("receiveTypeCd", "");            //입금유형
			inValueData.put("sysClass", list.getMapValue(0, "sysClass"));           //시스템구분
			inValueData.put("receiveAmt", inValueData.get("useAmt"));               //입금금액
			inValueData.put("deducAmt", 0);                                         //공제금액
			inValueData.put("arWithdrawAmt", inValueData.get("useAmt"));            //회수금액
			inValueData.put("inqueryStartDate", inValueData.get("occurDateFr"));    //조회시작일자
			inValueData.put("inqueryEndDate", inValueData.get("occurDateTo"));      //조회종료일자
			inValueData.put("inqueryMuCd", inValueData.get("muCd"));                //조회사업부
			inValueData.put("inqueryCcCd", ccCd);                                   //조회업장CC
			inValueData.put("inqueryCustCd", inValueData.get("custCd"));            //조회고객사
			inValueData.put("inqueryArTypeCd", "A05");                              //조회채권유형(상품권청구)
			insRowCnt += receiveMgntPopDAO.insertMst(inValueData);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				if(rowData.get("chk").toString().equals("1")){
					rowData.put("giftBillingYn", "Y");
					rowData.put("giftBillingNum", maxBillingNum);
					rowData.put("receiveNum", maxReceiveNum);
					//상품권 회수정보에 청구번호 업데이트 처리
					updRowCnt += giftBillingPopDAO.updateWithdraw(rowData);
					
					//입금상세 처리
					rowData.put("receiveDate", inValueData.get("occurDate"));
					rowData.put("arAmt", rowData.get("giftAmt"));
					rowData.put("receiveAmt", rowData.get("giftAmt"));		//rowData.put("receiveAmt", rowData.get("billingAmt"));
					rowData.put("balAmt", "0");
					rowData.put("custCd", inValueData.get("custCd"));
					rowData.put("acctCd", mapData.get("acctCd"));
					insRowCnt += receiveMgntPopDAO.insertDetail(rowData);
					
					//채권마스터 입금 처리 업데이트
					updRowCnt += arMstProcessDAO.updateReceive(rowData);
				}
	
			}
		}else{
			ccCdSch = (String) inValueData.get("ccCdSch");
			ccCd    = (String) inValueData.get("ccCd");
			
			/*데이터 셋팅*/
			inValueData.put("fiscalDate", inValueData.get("occurDate"));		//회계일자
			inValueData.put("arOccurClass", "AO06");		//채권발생유형코드
			inValueData.put("arTypeCd", "A05");		//채권유형코드
			inValueData.put("ccCd", ccCdSch);                //input업장CC   ccCd에 다시 셋팅
			
			inValueData.put("recdStatus", "L");		//레코드 상태
			
			insRowCnt += arMstProcessDAO.update(inValueData);
			
			//상품권 청구번호 생성(MAX값 조회)
			inValueData.put("ccCd", ccCd);                //ccCd에 다시 셋팅
			insRowCnt += giftBillingPopDAO.update(inValueData);
			
			
			//입금마스터 업데이트 처리
			inValueData.put("receiveNum", list.getMapValue(0, "receiveNum"));
			inValueData.put("receiveAmt", inValueData.get("useAmt"));               //입금금액
			inValueData.put("deducAmt", 0);                                         //공제금액
			inValueData.put("arWithdrawAmt", inValueData.get("useAmt"));            //회수금액
			insRowCnt += receiveMgntPopDAO.updateMst(inValueData);
			
			for (int i = 0 ; i < list.size() ; i++) {
				Map<String, Object> rowData = list.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				if(rowData.get("chk").toString().equals("1")){
					rowData.put("giftBillingYn", "Y");
					rowData.put("giftBillingNum", inValueData.get("giftBillingNum"));
					
					//입금상세 처리
					rowData.put("arAmt", rowData.get("giftAmt"));
					rowData.put("receiveAmt", rowData.get("giftAmt"));
					rowData.put("balAmt", "0");
					
					updRowCnt += receiveMgntPopDAO.updateDetail(rowData);
					
					//채권마스터 입금 처리 업데이트
					updRowCnt += arMstProcessDAO.updateReceive(rowData);
				}else{
					rowData.put("giftBillingYn", null);
					rowData.put("giftBillingNum", null);
				}
				//상품권 회수정보에 청구번호 업데이트 처리
				updRowCnt += giftBillingPopDAO.updateWithdraw(rowData);
	
			}			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 상품권 청구처리 DataSetMap의 데이터를 rowType에 따라 취소 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap inData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//매출번호 생성(MAX값 조회)
		String maxArNum;
		Map<String, Object> inValueData = inData.get(0);
		

		/*데이터 셋팅*/
		inValueData.put("arOccurClass", "AO06");		//채권유형코드
		inValueData.put("arTypeCd", "A05");		//채권유형코드
		
		inValueData.put("recdStatus", "D");		//레코드 상태
		
		insRowCnt += arMstProcessDAO.cancelArMst(inValueData);
		
		//상품권 청구번호 생성(MAX값 조회)
		insRowCnt += giftBillingPopDAO.delete(inValueData);
		
		//입금마스터 취소처리
		inValueData.put("receiveNum", list.getMapValue(0, "receiveNum"));
		delRowCnt += receiveMgntPopDAO.cancleMst(inValueData);
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if(rowData.get("chk").toString().equals("1")){
				rowData.put("giftBillingYn", null);
				rowData.put("giftBillingNum", null);
				rowData.put("receiveNum", null);
				//상품권 회수정보에 청구번호 업데이트 처리
				updRowCnt += giftBillingPopDAO.updateWithdraw(rowData);
				
				//취소 처리
				delRowCnt += receiveMgntPopDAO.cancleDetail(rowData);
				
				//채권마스터 입금 처리 업데이트
				updRowCnt += arMstProcessDAO.updateReceive(rowData);
			}

		}
	
		return insRowCnt + updRowCnt + delRowCnt;
	}	
}
