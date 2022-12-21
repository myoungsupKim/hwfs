package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralDeadDeadSheetDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 거래명세서 관리하는 FuneralDeadDeadSheet Service Implementation
 * 
 * @ClassName FuneralDeadDeadSheetServiceImpl.java
 * @Description FuneralDeadDeadSheetServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralDeadDeadSheetService")
public class FuneralDeadDeadSheetServiceImpl extends DefaultServiceImpl implements FuneralDeadDeadSheetService {
		
	/** FuneralDeadDeadSheetDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralDeadDeadSheetDAO")
	private FuneralDeadDeadSheetDAO funeralDeadDeadSheetDAO;
	
	/**
	 * 고인 목록을 조회한다.
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
	public RecordSet selectDeadGuestList(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectDeadGuestList(mapParam);
	}
	
	//마감조회
	public RecordSet selectClose(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectClose(mapParam);
	}
	
	/**
	 * 거래명세서 관리 목록을 조회한다.
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
	public Map<String, RecordSet> selectFuneralDeadDeadSheetList(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs1 = funeralDeadDeadSheetDAO.selectFuneralDeadDeadSheetList(mapParam);
		RecordSet rs2 = funeralDeadDeadSheetDAO.selectPayWayList(mapParam);
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("sheet", rs1);
		rsMap.put("payWay", rs2);
		return rsMap;
	}
	
	/**
	 * 과세유형 combo 를 조회한다.
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
	public Map<String, RecordSet> selectVatClass(Map<String, Object> mapParam) throws Exception {
		
		RecordSet rs1 = funeralDeadDeadSheetDAO.selectVatClass(mapParam);		
		RecordSet rs2 = funeralDeadDeadSheetDAO.selectFrncStorNum(mapParam);
		RecordSet rs3 = funeralDeadDeadSheetDAO.selectPosClass(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("vatClass", rs1);
		rsMap.put("num", rs2);
		rsMap.put("posClass", rs3);
		return rsMap;
	}
	

	public RecordSet selectCcCd(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectCcCd(mapParam);
	}
	
	/**
	 * 가맹점번호 combo 를 조회한다.
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
	public RecordSet selectFrncStorNum(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectFrncStorNum(mapParam);
	}
	
	/**
	 * 거래명세서 간단,상세를 조회한다.
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
	public RecordSet selectFuneralDeadDeadSheet(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectFuneralDeadDeadSheetList(mapParam);
	}
	
	/**
	 * 결재수단 리스트을 조회한다.
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
	public RecordSet selectPayWayList(Map<String, Object> mapParam) throws Exception {
		return funeralDeadDeadSheetDAO.selectPayWayList(mapParam);
	}
	
	
	/**
	 * 결재수단 리스트를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	public int savePayWayList(DataSetMap list) throws Exception {
		
		String curMaxNum = null;
		int closeCnt = 0;	// 마감여부
		//String rtnStr = null;
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
				
		for (int i = 0 ; i < list.size() ; i++) {
			@SuppressWarnings("unchecked")
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {				
				
				// 마감여부 체크
				closeCnt = Integer.parseInt(funeralDeadDeadSheetDAO.selectClose2(rowData).getRecord(0).get("cnt").toString());

				if(closeCnt<=0) {
					
					// 영수증 번호 채번
					curMaxNum = funeralDeadDeadSheetDAO.selectReceiptNum(rowData).getRecord(0).get("receiptNum").toString();
					rowData.put("receiptNum", curMaxNum);
					
					// 업장 발생 매출 마스터 insert
					insRowCnt += funeralDeadDeadSheetDAO.insertSlaIfUpjangSalsMst(rowData);
					// 업장 발생 매출 상세 insert
					insRowCnt += funeralDeadDeadSheetDAO.insertSlaIfUpjangSalsDetail(rowData);
					// 업장 발생 매출 payment insert
					insRowCnt += funeralDeadDeadSheetDAO.insertSlaIfUpjangPayment(rowData);
					
					if(rowData.get("payCd").equals("2")){
						// 카드 승인 정보 insert
						insRowCnt += funeralDeadDeadSheetDAO.insertSlaIfCardApprvInfo(rowData);
					}
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// 업장 발생 매출 마스터 update
				updRowCnt += funeralDeadDeadSheetDAO.updateSlaIfUpjangSalsMst(rowData);
				// 업장 발생 매출 상세 update
				insRowCnt += funeralDeadDeadSheetDAO.updateSlaIfUpjangSalsDetail(rowData);
				// 업장 발생 매출 payment update
				insRowCnt += funeralDeadDeadSheetDAO.updateSlaIfUpjangPayment(rowData);
				
				if(rowData.get("payCd").equals("2")){
					// 카드 승인 정보 update
					insRowCnt += funeralDeadDeadSheetDAO.updateSlaIfCardApprvInfo(rowData);
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				
				// 업장 발생 매출 상세 delete
				insRowCnt += funeralDeadDeadSheetDAO.deleteSlaIfUpjangSalsDetail(rowData);
				// 업장 발생 매출 payment delete
				insRowCnt += funeralDeadDeadSheetDAO.deleteSlaIfUpjangPayment(rowData);
				
				if(rowData.get("payCd").equals("2")){
					// 카드 승인 정보 delete
					insRowCnt += funeralDeadDeadSheetDAO.deleteSlaIfCardApprvInfo(rowData);
				}
				
				// 업장 발생 매출 마스터 delete
				delRowCnt += funeralDeadDeadSheetDAO.deleteSlaIfUpjangSalsMst(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
