package com.hwfs.sm.sar.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sm.sar.dao.ArCustTransferPopDAO;
import com.hwfs.sm.sar.dao.ArMstProcessDAO;
import com.hwfs.sm.sar.dao.ReceiveMgntPopDAO;

 /**
 * 채권 거래처/업장 이관 처리하는 ArCustTransferPop Service Implementation
 * 
 * @ClassName ArCustTransferPopServiceImpl.java
 * @Description ArCustTransferPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.28    김명호        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김명호
 * @since 2015.04.28
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sm/sar/arCustTransferPopService")
public class ArCustTransferPopServiceImpl extends DefaultServiceImpl implements ArCustTransferPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** ArCustTransferPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/arCustTransferPopDAO")
	private ArCustTransferPopDAO arCustTransferPopDAO;
	
	/** ReceiveMgntPopDAO Bean 생성 */
	@Resource(name = "/sm/sar/receiveMgntPopDAO")
	private ReceiveMgntPopDAO receiveMgntPopDAO;
	
	/** ArMstProcessDAO Bean 생성 */
	@Resource(name = "/sm/sar/arMstProcessDAO")
	private ArMstProcessDAO arMstProcessDAO;
	
	/**
	 * 채권 거래처/업장 이관 처리 목록을 조회한다.
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
		return arCustTransferPopDAO.selectList(mapParam);
	}
	
	/**
	 * 채권 거래처/업장 이관 처리 시 거래처에 해당되는 업장목록을 조회한다.
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
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return arCustTransferPopDAO.selectUpjangList(mapParam);
	}

	/**
	 * 채권 거래처/업장 이관 처리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, DataSetMap receiveData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String maxReceiveNum="";
		String maxUpjangSalsNum=""; //업장매출번호
		
		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);
		
		//업장매출등록용
		Map<String, Object> rowUpjangData = new HashMap<String, Object>();
		
		//생성인지 수정인지 조건 체크
		if(rowReceiveData.get("receiveNum").toString().isEmpty()){
			//입금처리 번호 생성(max값)
			maxReceiveNum =  receiveMgntPopDAO.selectMaxReceiveNum(rowReceiveData);
			rowReceiveData.put("receiveNum", maxReceiveNum);
			//초기값 셋팅
			rowReceiveData.put("muCd", rowReceiveData.get("inqueryMuCd"));
			rowReceiveData.put("ccCd", rowReceiveData.get("inqueryCcCd"));
			rowReceiveData.put("custCd", rowReceiveData.get("inqueryCustCd"));
			
			//수정 처리
			insRowCnt += receiveMgntPopDAO.insertMst(rowReceiveData);
			//입금 수단
			insRowCnt += receiveMgntPopDAO.insertReceiveWay(rowReceiveData);
			
			//사업부가 FS사업부인경우 업장매출확보 발생 +-
			if ("2002".equals(rowReceiveData.get("muCd"))){
				rowUpjangData.put("salsDate", rowReceiveData.get("receiveDate"));   //매출일자
				rowUpjangData.put("sysClass", "11");                                //시스템구분
				rowUpjangData.put("muCd", rowReceiveData.get("muCd"));
				
				rowUpjangData.put("salsClass", rowReceiveData.get("salsClass"));
				rowUpjangData.put("occurClass", "1");
				rowUpjangData.put("acctCd", rowReceiveData.get("acctCd"));
				rowUpjangData.put("salsAmt", rowReceiveData.get("receiveAmt"));
				rowUpjangData.put("upjangCd", rowReceiveData.get("upjangCd"));
				rowUpjangData.put("recdStatus", "L");
				for (int i = 0; i < 2; i++){
					maxUpjangSalsNum = arCustTransferPopDAO.selectMaxUpjangSalsNum(rowUpjangData);
					rowUpjangData.put("upjangSalsNum", maxUpjangSalsNum);
					if (i == 0){
						if(rowReceiveData.get("receiveTypeCd").equals("B07")){
							rowUpjangData.put("custCd", rowReceiveData.get("transCustCd"));
							rowUpjangData.put("ccCd", rowReceiveData.get("ccCd"));							
						}else{
							rowUpjangData.put("custCd", rowReceiveData.get("inqueryCustCd"));
							rowUpjangData.put("ccCd", rowReceiveData.get("transCcCd"));							
						}
						rowUpjangData.put("seq", "0");
					} else {
						rowUpjangData.put("custCd", rowReceiveData.get("inqueryCustCd"));
						rowUpjangData.put("ccCd", rowReceiveData.get("ccCd"));	
						rowUpjangData.put("seq", "1");
					}
					rowUpjangData.put("receiveNum", maxReceiveNum);
					insRowCnt += arCustTransferPopDAO.insertUpjangSals(rowUpjangData);
				}
			}
		}else{
			maxReceiveNum = rowReceiveData.get("receiveNum").toString();
			//사업부가 FS사업부인경우 업장매출확보 발생 +-
			if ("2002".equals(rowReceiveData.get("muCd"))){
				delRowCnt += arCustTransferPopDAO.deleteUpjangSals(rowReceiveData);
				
				rowUpjangData.put("salsDate", rowReceiveData.get("receiveDate"));   //매출일자
				rowUpjangData.put("sysClass", "11");                                //시스템구분
				rowUpjangData.put("muCd", rowReceiveData.get("muCd"));
				
				rowUpjangData.put("salsClass", rowReceiveData.get("salsClass"));
				rowUpjangData.put("occurClass", "1");
				rowUpjangData.put("acctCd", rowReceiveData.get("acctCd"));
				rowUpjangData.put("salsAmt", rowReceiveData.get("receiveAmt"));
				rowUpjangData.put("upjangCd", rowReceiveData.get("upjangCd"));
				rowUpjangData.put("recdStatus", "L");
				for (int i = 0; i < 2; i++){
					maxUpjangSalsNum = arCustTransferPopDAO.selectMaxUpjangSalsNum(rowUpjangData);
					rowUpjangData.put("upjangSalsNum", maxUpjangSalsNum);
					if (i == 0){
						if(rowReceiveData.get("receiveTypeCd").equals("B07")){
							rowUpjangData.put("custCd", rowReceiveData.get("transCustCd"));
							rowUpjangData.put("ccCd", rowReceiveData.get("ccCd"));							
						}else{
							rowUpjangData.put("custCd", rowReceiveData.get("inqueryCustCd"));
							rowUpjangData.put("ccCd", rowReceiveData.get("transCcCd"));							
						}
						rowUpjangData.put("seq", "0");
					} else {
						rowUpjangData.put("custCd", rowReceiveData.get("inqueryCustCd"));
						rowUpjangData.put("ccCd", rowReceiveData.get("ccCd"));	
						rowUpjangData.put("seq", "1");
					}
					rowUpjangData.put("receiveNum", maxReceiveNum);
					insRowCnt += arCustTransferPopDAO.insertUpjangSals(rowUpjangData);
				}
			}			
			//수정 처리
			insRowCnt += receiveMgntPopDAO.updateMst(rowReceiveData);	
			//입금 수단
			updRowCnt += receiveMgntPopDAO.updateReceiveWay(rowReceiveData);
		}
		
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			//입금 처리
			if (rowData.get("arAltNum").toString().equals("0")){
				//입금 처리 상세 Insert 처리
				rowData.put("receiveNum", maxReceiveNum);
				rowData.put("receiveDate", rowReceiveData.get("receiveDate"));
				rowData.put("remarks", rowReceiveData.get("remark"));
				rowData.put("batchId", rowReceiveData.get("batchId"));
				rowData.put("recdStatus", "L");
				
				insRowCnt += receiveMgntPopDAO.insertDetail(rowData);
				
			}else{
				//입금 처리 상세 UPDATE 처리
				if(rowData.get("receiveAmt").toString().equals("0")) {	//입금처리액을 0으로 만들었을 경우 삭제처리한다
					rowData.put("recdStatus", "D");			
					rowData.put("batchId", "");
					
					updRowCnt += receiveMgntPopDAO.deleteDetail(rowData);
				}else{
					rowData.put("recdStatus", "L");					
					rowData.put("remarks", rowReceiveData.get("remark"));
					rowData.put("batchId", rowReceiveData.get("batchId"));
					
					updRowCnt += receiveMgntPopDAO.updateDetail(rowData);
				}	
				
			}
			
			//입금된 만큼 새로운 거래처 또는 업장으로 채권을 발생시킨다.
			//1. 새로운 채권 번호 생성
			String maxArNum;
			Map<String, Object> newArData = new HashMap();
			
			newArData.put("occurDate", rowReceiveData.get("receiveDate"));
			
			newArData.put("fiscalDate", rowReceiveData.get("receiveDate"));			//발생일자는 전 발생일자와 동일하며 회계일자가 이관 일자로 됨.
			
			if(rowReceiveData.get("receiveTypeCd").equals("B07")){
				newArData.put("upjangCd", rowReceiveData.get("upjangCd"));      //업장
				newArData.put("arOccurClass", "AO02");		//채권발생구분	- 고객사 이관
			}else{
				
				newArData.put("arOccurClass", "AO03");		//채권발생구분	- 부서이관
			}
			newArData.put("arAmt", rowData.get("receiveAmt"));		//채권금액
			newArData.put("mngmvArNum", rowData.get("arNum"));		//이관(이전) 채권 번호
			newArData.put("remark", rowReceiveData.get("remark"));		//비고
			newArData.put("custCd", rowReceiveData.get("transCustCd"));		//이관거래처
			newArData.put("custNm", rowReceiveData.get("transCustNm"));		//이관 거래처명
			newArData.put("ccCd", rowReceiveData.get("transCcCd"));		//CC코드
			newArData.put("muCd", rowReceiveData.get("inqueryMuCd"));		//사업부
			newArData.put("refNum", rowReceiveData.get("receiveNum"));		//이관 대체 입금 번호
			newArData.put("batchId", rowReceiveData.get("batchId"));
			
			newArData.put("recdStatus", "L");		//상태값
			//신규일경우
			if (rowData.get("arAltNum").toString().equals("0")){
				//새롭게 이관된 채권에 대해서만 채권번호를 발행하고 수정/삭제일경우는 부모 채권번호(MNGMV_AR_NUM)와 대체입금번호(REF_NUM)을 이용해서 수정 삭제 처리 한다.
				maxArNum =  arMstProcessDAO.selectMaxArNum(newArData);
				newArData.put("arNum", maxArNum);		//새로운 채권번호
				
				updRowCnt += arMstProcessDAO.insertTransSelect(newArData);	
			}else{
				//이관된 채권 번호를 수정
				if(rowData.get("receiveAmt").toString().equals("0")) {	//입금처리액을 0으로 만들었을 경우 삭제처리한다
					updRowCnt += arMstProcessDAO.deleteTrans(newArData);
				}else{
					updRowCnt += arMstProcessDAO.updateTrans(newArData);
				}					
			}
			
			//채권마스터 입금 처리 업데이트
			updRowCnt += arMstProcessDAO.updateReceive(rowData);
			
			
			
		}
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 입금처리 DataSetMap의 데이터를 rowType에 따라 취소 처리한다.
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
	public int cancleList(DataSetMap list, DataSetMap receiveData) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		//입금 처리 등록
		Map<String, Object> rowReceiveData = receiveData.get(0);
		

		//취소 처리
		delRowCnt += receiveMgntPopDAO.cancleMst(rowReceiveData);			
		delRowCnt += receiveMgntPopDAO.cancleReceiveWay(rowReceiveData);			
		if ("2002".equals(rowReceiveData.get("muCd"))){
			delRowCnt += arCustTransferPopDAO.deleteUpjangSals(rowReceiveData);
		}
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			if (!rowData.get("arAltNum").toString().equals("0")){
				//취소 처리
				delRowCnt += receiveMgntPopDAO.cancleDetail(rowData);
					
	
				//채권마스터 이관 취서 처리
				Map<String, Object> newArData = new HashMap();
				newArData.put("mngmvArNum", rowData.get("arNum"));		//이관(이전) 채권 번호
				newArData.put("refNum", rowReceiveData.get("receiveNum"));		//이관 대체 입금 번호
				
				updRowCnt += arMstProcessDAO.cancleTrans(newArData);
				
				//채권마스터 입금 처리 업데이트
				updRowCnt += arMstProcessDAO.updateReceive(rowData);
			}
			
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
}
