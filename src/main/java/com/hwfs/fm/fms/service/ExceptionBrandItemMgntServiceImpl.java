package com.hwfs.fm.fms.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.fm.fms.dao.ExceptionBrandItemMgntDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 발주제한상품(브랜드) 등록하는 ExceptionBrandItemMgnt Service Implementation
 * 
 * @ClassName ExceptionBrandItemMgntServiceImpl.java
 * @Description ExceptionBrandItemMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2022.10.24    hye.jin94        최초생성
 *  
 * </pre>
 * @author Jaey
 * @since 2021.07.21
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fm/fms/exceptionBrandItemMgntService")
public class ExceptionBrandItemMgntServiceImpl extends DefaultServiceImpl implements ExceptionBrandItemMgntService {
	
	/** EventMgntDAO Bean 생성 */
	@Resource(name = "/fm/fms/exceptionBrandItemMgntDAO")
	private ExceptionBrandItemMgntDAO exceptionBrandItemMgntDAO;
	

	/**
	 * 브랜드 업장목록 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectUpjangList(Map<String, Object> mapParam) throws Exception {
		return exceptionBrandItemMgntDAO.selectUpjangList(mapParam);
	}
	
	/**
	 * 발주제한상품 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectItemList(Map<String, Object> mapParam) throws Exception {
		return exceptionBrandItemMgntDAO.selectItemList(mapParam);
	}
	
	
	/**
	 * 상품관리 등록(발주제한여부) DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveItemInfo(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String strChk = "0";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			strChk = LimsUtil.checkNull(rowData.get("chk"));
			if ("1".equals(strChk)) {			
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					Record r = exceptionBrandItemMgntDAO.selectItemDupCnt(rowData);
					
					if (r.getInt("cnt") > 0) {
						throw new BizException("이미 등록된 상품이 존재합니다.\n[" + rowData.get("itemCode")+"] "+rowData.get("itemName"));
					}					
					
					insRowCnt += exceptionBrandItemMgntDAO.insertItemInfo(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updRowCnt += exceptionBrandItemMgntDAO.updateItemInfo(rowData);
				}
			}
		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	
	/**
	 * 발주제한상품 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteExceptionItem(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int insCnt = 0;
		int delCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Delete 처리
			if (isCheck) {
				//insCnt += exceptionBrandItemMgntDAO.insertItemDeleteHist(rowData); //행사자재 삭제 히스토리
				delCnt += exceptionBrandItemMgntDAO.deleteExceptionItem(rowData); //발주제한자재 삭제
			}
		}
		
		return insCnt + delCnt;
	}
	

	/**
	 * 발주제한상품관리 엑셀 조회
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectItemListExcel(DataSetMap list) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			RecordSet rs = exceptionBrandItemMgntDAO.selectItemListExcel(rowData);
			
			if(rs.isEmpty()){				
				rowData.put("itemCode", rowData.get("itemCode"));
				rowData.put("useYn", rowData.get("useYn"));
				rowData.put("itemCode", "");
				rowData.put("itemName", "");
				rowData.put("itemSize", "");
				rowData.put("contractPrice", "0");
				rowData.put("salePrice", "0");
				rowData.put("itemSize", "");
			} else {
				Map<String, Object> chkRowData = rs.get(0);
				rowData.put("itemCode", rowData.get("itemCode"));
				rowData.put("useYn", rowData.get("useYn"));
				rowData.put("itemCode", chkRowData.get("itemCode"));
				rowData.put("itemName", chkRowData.get("itemName"));
				rowData.put("itemSize", chkRowData.get("itemSize"));
				rowData.put("contractPrice", chkRowData.get("contractPrice"));
				rowData.put("salePrice", chkRowData.get("salePrice"));
			}
			
			itemList.add(rowData);
		}
		
		rtnMap.put("itemList", itemList);
		return rtnMap;
	}		
	
	
	
	
	
	
	/**
	 * 행사그룹관리 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectEventList(Map<String, Object> mapParam) throws Exception {
		return exceptionBrandItemMgntDAO.selectEventList(mapParam);
	}

	/**
	 * 행사그룹관리 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveEventInfo(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String strChk = "0";
		String strApplyEd = "";
		String strApplyEdOrg = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			strChk = LimsUtil.checkNull(rowData.get("chk"));
            if ("1".equals(strChk)) {
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					insRowCnt += exceptionBrandItemMgntDAO.insertEventInfo(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updRowCnt += exceptionBrandItemMgntDAO.updateEventInfo(rowData);
					
					//이벤트종료일 변경시 업장종료일 변경
					strApplyEd = LimsUtil.checkNull(rowData.get("applyEd"));
					strApplyEdOrg = LimsUtil.checkNull(rowData.get("applyEdOrg"));
					if (!strApplyEd.equals(strApplyEdOrg)) {
						updRowCnt += exceptionBrandItemMgntDAO.updateUpjangApplyEd(rowData);
					}
				}
            }
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	
	
	/**
	 * 행사거래처관리 등록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveUpjangInfo(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String strChk = "0";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			strChk = LimsUtil.checkNull(rowData.get("chk"));
            if ("1".equals(strChk)) {	
            	
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					Record r = exceptionBrandItemMgntDAO.selectUpjangDupCnt(rowData);
					
					if (r.getInt("cnt") > 0) {
						throw new BizException("이미 등록된 거래처가 존재합니다.\n[" + rowData.get("upjangCd")+"] "+rowData.get("upjangNm"));
					}
					
					insRowCnt += exceptionBrandItemMgntDAO.insertUpjangInfo(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					updRowCnt += exceptionBrandItemMgntDAO.updateUpjangInfo(rowData);
				}
            }
		}
		
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 행사거래처관리엑셀 조회
	 * 
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectUpjangListExcel(DataSetMap list) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<Map<String, Object>> upjangList = new ArrayList<Map<String, Object>>();
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			
			RecordSet rs = exceptionBrandItemMgntDAO.selectUpjangListExcel(rowData);
			if(rs.isEmpty()){
				
				rowData.put("upjangCd", rowData.get("upjangCd"));
				rowData.put("useYn", rowData.get("useYn"));
				rowData.put("apUnitpriceUpjang", "");
				rowData.put("apUnitpriceUpjangNm", "");
				rowData.put("upjangNm", "");
			} else {
				Map<String, Object> chkRowData = rs.get(0);
				rowData.put("upjangCd", rowData.get("upjangCd"));
				rowData.put("useYn", rowData.get("useYn"));
				rowData.put("apUnitpriceUpjang", chkRowData.get("apUnitpriceUpjang"));
				rowData.put("apUnitpriceUpjangNm", chkRowData.get("apUnitpriceUpjangNm"));
				rowData.put("upjangNm", chkRowData.get("upjangnmDisp"));
			}
			
			upjangList.add(rowData);
		}
		
		rtnMap.put("upjangList", upjangList);
		return rtnMap;
	}	

	
	/**
	 * 행사그룹이력 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectEventHistList(Map<String, Object> mapParam) throws Exception {
		mapParam.put("changeGnb", "EVENT");
		return exceptionBrandItemMgntDAO.selectEventHistList(mapParam);
	}
	
	/**
	 * 행사거래처이력 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectEventUpjangHistList(Map<String, Object> mapParam) throws Exception {
		mapParam.put("changeGnb", "UPJANG");
		return exceptionBrandItemMgntDAO.selectEventHistList(mapParam); 
	}
	
	/**
	 * 행사상품이력 조회
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectEventItemHistList(Map<String, Object> mapParam) throws Exception {
		mapParam.put("changeGnb", "ITEM");
		return exceptionBrandItemMgntDAO.selectEventHistList(mapParam);
	}	
	
	/**
	 * 행사그룹관리 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteEventGroup(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int insCnt = 0;
		int delCnt = 0;
		int updCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Delete 처리
			if (isCheck) {
				//insCnt += exceptionBrandItemMgntDAO.insertUpjangDeleteHist(rowData); //행사거래처 삭제 히스토리
				//delCnt += exceptionBrandItemMgntDAO.deleteEventUpjang(rowData); //행사거래처 삭제
				
				//insCnt += exceptionBrandItemMgntDAO.insertItemDeleteHist(rowData); //행사자재 삭제 히스토리
				//delCnt += exceptionBrandItemMgntDAO.deleteExceptionItem(rowData); //행사자재 삭제
				
				//updCnt += exceptionBrandItemMgntDAO.updateEventUseYn(rowData); //행사그룹 사용여부 'N'처리
			}
		}
		
		return insCnt + delCnt + updCnt;
	}
	
	/**
	 * 행사거래처관리 삭제
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int deleteEventUpjang(DataSetMap list, LoginDTO loginDTO) throws Exception {
		int insCnt = 0;
		int delCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			boolean isCheck = StringUtils.equals("1", (String)rowData.get("chk")); //chk가 1인 건만 처리함 (ui에서 CHECKBOX가 선택된 건)
			
			//Delete 처리
			if (isCheck) {
				insCnt += exceptionBrandItemMgntDAO.insertUpjangDeleteHist(rowData); //행사거래처 삭제 히스토리
				delCnt += exceptionBrandItemMgntDAO.deleteEventUpjang(rowData); //행사거래처 삭제
			}
		}
		
		return insCnt + delCnt;
	}
	
	
}
