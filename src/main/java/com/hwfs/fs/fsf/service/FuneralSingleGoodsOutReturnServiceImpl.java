package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralSingleGoodsOutReturnDAO;
import com.hwfs.fs.fsf.dao.FuneralDeadDeadSheetDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 고인별 판매품목 출고/반품관리하는 FuneralSingleGoodsOutReturn Service Implementation
 * 
 * @ClassName FuneralSingleGoodsOutReturnServiceImpl.java
 * @Description FuneralSingleGoodsOutReturnServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.20    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralSingleGoodsOutReturnService")
public class FuneralSingleGoodsOutReturnServiceImpl extends DefaultServiceImpl implements FuneralSingleGoodsOutReturnService {
	
	/** FuneralDeadDeadSheetService Bean 생성 */
	@Resource(name = "/fs/fsf/funeralDeadDeadSheetService")
	private FuneralDeadDeadSheetService funeralDeadDeadSheetService;
	
	/** FuneralSingleGoodsOutReturnDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralSingleGoodsOutReturnDAO")
	private FuneralSingleGoodsOutReturnDAO funeralSingleGoodsOutReturnDAO;
	
	/** FuneralDeadDeadSheetDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralDeadDeadSheetDAO")
	private FuneralDeadDeadSheetDAO funeralDeadDeadSheetDAO;
	
	/**
	 * 상품구분 코드리스트를 조회한다.
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
	public RecordSet selectSetCd(Map<String, Object> mapParam) throws Exception {
		return funeralSingleGoodsOutReturnDAO.selectSetCd(mapParam);
	}
	
	/**
	 * 상품분류, 상세상품 코드리스트를 조회한다.
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
	public RecordSet selectCodeList1(Map<String, Object> mapParam) throws Exception {
		return funeralSingleGoodsOutReturnDAO.selectCodeList1(mapParam);
	}
	public RecordSet selectCodeList2(Map<String, Object> mapParam) throws Exception {
		return funeralSingleGoodsOutReturnDAO.selectCodeList2(mapParam);
	}
	public RecordSet selectCodeList3(Map<String, Object> mapParam) throws Exception {
		return funeralSingleGoodsOutReturnDAO.selectCodeList3(mapParam);
	}
	
	/**
	 * 반품대상 상품의 총 판매수량을 조회한다.(입력시, 반품 수량 실시간 체크)
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
	public RecordSet searchSaleCount(Map<String, Object> mapParam) throws Exception {
		return funeralSingleGoodsOutReturnDAO.searchSaleCount(mapParam);
	}
	
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
		return funeralSingleGoodsOutReturnDAO.selectDeadGuestList(mapParam);
	}
	
	/**
	 * 고인별 총액산출및 판매품목 출고/반품관리(을)를 조회한다.
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
	public Map<String, RecordSet> selectGoodsSaleoutReturnList(Map<String, Object> mapParam) throws Exception {
		
		mapParam.put("saleClass", "001");	// 판매 목록
		RecordSet rs1 = funeralSingleGoodsOutReturnDAO.selectGoodsSaleoutReturn(mapParam);
		mapParam.put("saleClass", "002");	// 반품 목록
		RecordSet rs2 = funeralSingleGoodsOutReturnDAO.selectGoodsSaleoutReturn(mapParam);
		RecordSet rs3 = funeralSingleGoodsOutReturnDAO.selectAdjustAmt(mapParam);
		mapParam.put("saleClass", "001");	// 판매 목록
		mapParam.put("kindType", "S");
		RecordSet rs4 = funeralSingleGoodsOutReturnDAO.selectGoodsSaleoutReturn(mapParam);
		mapParam.put("saleClass", "002");	// 반품 목록
		mapParam.put("kindType", "S");
		RecordSet rs5 = funeralSingleGoodsOutReturnDAO.selectGoodsSaleoutReturn(mapParam);
		
		RecordSet rs6 = funeralDeadDeadSheetDAO.selectFuneralDeadDeadSheetList(mapParam);
		RecordSet rs7 = funeralDeadDeadSheetDAO.selectPayWayList(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("goodsSaleout", rs1);
		rsMap.put("goodsReturn", rs2);
		rsMap.put("adjustAmt", rs3);
		rsMap.put("goodsSaleoutS", rs4);
		rsMap.put("goodsReturnS", rs5);
		
		rsMap.put("sheet", rs6);
		rsMap.put("payWay", rs7);
		
		return rsMap;
	}

	/**
	 * 고인별 판매품목 출고/반품관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public Map<String, Object> saveGoodsSaleoutReturnList(Map<String, DataSetMap> mapParam) throws Exception {
		
		DataSetMap dsGoodsSaleoutS = mapParam.get("ds_goodsSaleoutS");
		DataSetMap dsGoodsReturnS = mapParam.get("ds_goodsReturnS");
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String rtnCnt = "0";
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("cnt", "0");
		
		for (int i = 0 ; i < dsGoodsSaleoutS.size() ; i++) {
			Map<String, Object> rowData = dsGoodsSaleoutS.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += funeralSingleGoodsOutReturnDAO.insertGoodsSale(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSingleGoodsOutReturnDAO.updateGoodsSale(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSingleGoodsOutReturnDAO.deleteGoodsSale(rowData);
			}
		}
		
		for (int i = 0 ; i < dsGoodsReturnS.size() ; i++) {
			Map<String, Object> rowData = dsGoodsReturnS.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 반품은 판매에 한해서 가능하며, 마이너스 반품은 불가
				String cnt = funeralSingleGoodsOutReturnDAO.selectSaleReturnCheck(rowData).getRecord(0).getString("cnt");
				if("0".equals(cnt)) {
					insRowCnt += funeralSingleGoodsOutReturnDAO.insertGoodsSale(rowData);
				}else{
					rtnCnt = "1";
				}
				
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				
				// 반품은 판매에 한해서 가능하며, 마이너스 반품은 불가
				String cnt = funeralSingleGoodsOutReturnDAO.selectSaleReturnCheck(rowData).getRecord(0).getString("cnt");
				if("0".equals(cnt)) {
					updRowCnt += funeralSingleGoodsOutReturnDAO.updateGoodsSale(rowData);
				}else{
					rtnCnt = "1";
				}
				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSingleGoodsOutReturnDAO.deleteGoodsSale(rowData);
			}
		}
		
		// 결재수단 저장
		DataSetMap dsPayWay = mapParam.get("ds_payWay");
		funeralDeadDeadSheetService.savePayWayList(dsPayWay);
		
		rtnMap.put("cnt", rtnCnt);
		rtnMap.put("procCnt", insRowCnt + updRowCnt + delRowCnt);
		return rtnMap;
	}
}
