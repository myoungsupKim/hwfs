package com.hwfs.fs.fsf.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsf.dao.FuneralSaleGoodsInfoMgntDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 판매상품군 정보관리하는 FuneralSaleGoodsInfoMgnt Service Implementation
 * 
 * @ClassName FuneralSaleGoodsInfoMgntServiceImpl.java
 * @Description FuneralSaleGoodsInfoMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.16    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.04.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsf/funeralSaleGoodsInfoMgntService")
public class FuneralSaleGoodsInfoMgntServiceImpl extends DefaultServiceImpl implements FuneralSaleGoodsInfoMgntService {
	
	/** FuneralSaleGoodsInfoMgntDAO Bean 생성 */
	@Resource(name = "/fs/fsf/funeralSaleGoodsInfoMgntDAO")
	private FuneralSaleGoodsInfoMgntDAO funeralSaleGoodsInfoMgntDAO;
	
	/**
	 * 세트등록(TAB2)_세트 코드 combo 리스트를 조회한다.
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
	public RecordSet selectSetCdCombo(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectSetCdCombo(mapParam);
	}
	
	/**
	 * 판매상품등록(TAB1)_매점상품 팝업 목록을 조회한다.
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
	public RecordSet selectStoreClassPopupList(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectStoreClassPopupList(mapParam);
	}
	
	/**
	 * 장례식장 판매상품군 정보관리, 세트코드 조회한다.
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
	public Map<String, RecordSet> selectFuneralSaleGoodsInputList(Map<String, Object> mapParam) throws Exception {
		
		//String orgClassCd = mapParam.get("goodsClassCd").toString();
		mapParam.put("goodsClassCd", "001");	// (TAB1)식사류
		RecordSet rs1 = funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);
		mapParam.put("goodsClassCd", "002");	// (TAB1)매점류
		RecordSet rs2 = funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);
		mapParam.put("goodsClassCd", "003");	// (TAB1)기타류
		RecordSet rs3 = funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);
		RecordSet rs4 = funeralSaleGoodsInfoMgntDAO.selectMclassList(mapParam);			// (TAB2) 세트명 등록 리스트
		mapParam.put("goodsClassCd", "");	
		RecordSet rs5 = funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);	// (TAB2) 판매상품목록		
		RecordSet rs6 = funeralSaleGoodsInfoMgntDAO.selectSclassList(mapParam);			// (TAB2) 세트 등록 리스트		
		RecordSet rs7 = funeralSaleGoodsInfoMgntDAO.selectSaleGoodsTotalList(mapParam);	// (TAB3) 판매 상품 목록
		mapParam.put("goodsClassCd", "006");	// (TAB1)협력업체
		RecordSet rs8 = funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("mealClass", rs1);
		rsMap.put("storeClass", rs2);
		rsMap.put("etcClass", rs3);
		rsMap.put("mClass", rs4);
		rsMap.put("saleClass", rs5);
		rsMap.put("sClass", rs6);
		rsMap.put("totalList", rs7);
		rsMap.put("custList", rs8);
		
		return rsMap;
	}
	
	//콤보변경에 따른 재조회
	public RecordSet selectSaleRegClassList(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectSaleRegClassList(mapParam);
	}
	public RecordSet selectSetList(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectSclassList(mapParam);
	}
	
	
	
	public String makeDtlCode(String strNum) {
		
		String rtnNum = null;
		int len = strNum.length();
		if(len==1) {
			rtnNum = "00"+(Integer.parseInt(strNum)+1);
		}else if(len==2) {
			rtnNum = "0"+(Integer.parseInt(strNum)+1);
		}else if(len==3) {
			
			rtnNum = String.valueOf(Integer.parseInt(strNum)+1);
			
			if(rtnNum.length()==0) {
				rtnNum = "001";
			}else if(rtnNum.length()==1) {
				rtnNum = "00"+ rtnNum;
			}else if(rtnNum.length()==2) {
				rtnNum = "0"+ rtnNum;
			}
			
		}else{
			rtnNum = "001";
		}
		return rtnNum;
	}
	
	/**
	 * 판매상품등록(TAB1)_상품 삭제가능 여부를 조회한다.
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
	public RecordSet selectGoodsDeleteYn(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectGoodsDeleteYn(mapParam);
	}
	public RecordSet selectSetDeleteYn(Map<String, Object> mapParam) throws Exception {
		return funeralSaleGoodsInfoMgntDAO.selectSetDeleteYn(mapParam);
	}
	
	/**
	 * 장례식장 관계자일경우 생성된 세트코드(을)를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveFuneralSaleGoodsInputList(Map<String, DataSetMap> param) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		String strMaxDtlNum = null;	
		String strDupFlag = null;
				
		DataSetMap mealClassList = param.get("ds_mealClassList");
		DataSetMap storeClassList = param.get("ds_storeClassList");
		DataSetMap etcClassList = param.get("ds_etcClassList");
		DataSetMap custClassList = param.get("ds_custClassList");
		DataSetMap mclassList = param.get("ds_mclassList");
		DataSetMap sclassList = param.get("ds_sclassList");
		
		// 식사류
		for (int i = 0 ; i < mealClassList.size() ; i++) {
			Map<String, Object> rowData = mealClassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 장례식장,군분류별 max detail cd
				strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectGoodsInputMax(rowData).get(0).getString("maxCd");				
				rowData.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
				insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSaleRegClassList(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateSaleRegClassList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteSaleRegClassList(rowData);				
			}		
		}
		
		// 매점상품
		for (int i = 0 ; i < storeClassList.size() ; i++) {
			Map<String, Object> rowData = storeClassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 신규 생성대상은 새로이 detailGoodsCd 를 생성.( 기존 구매시스템(팝업)에서 가져온 상품일경우, 기존 코드 유지.)
				if(rowData.get("detailGoodsCd").toString().length() <= 3) {
					// 장례식장,군분류별 max detail cd
					strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectGoodsInputMax(rowData).get(0).getString("maxCd");				
					rowData.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
				}
				insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSaleRegClassList(rowData);		
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateSaleRegClassList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteSaleRegClassList(rowData);				
			}		
		}
		
		// 기타상품
		for (int i = 0 ; i < etcClassList.size() ; i++) {
			Map<String, Object> rowData = etcClassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 장례식장,군분류별 max detail cd
				strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectGoodsInputMax(rowData).get(0).getString("maxCd");				
				rowData.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
				
				insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSaleRegClassList(rowData);		
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateSaleRegClassList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteSaleRegClassList(rowData);				
			}		
		}
		
		// 협력업체
		for (int i = 0 ; i < custClassList.size() ; i++) {
			Map<String, Object> rowData = custClassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 장례식장,군분류별 max detail cd
				strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectGoodsInputMax(rowData).get(0).getString("maxCd");				
				rowData.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
				
				insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSaleRegClassList(rowData);		
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateSaleRegClassList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteSaleRegClassList(rowData);				
			}		
		}
		
		// 세트명 등록
		for (int i = 0 ; i < mclassList.size() ; i++) {
			Map<String, Object> rowData = mclassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				
				// 장례식장 max set code 조회
				strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectMclassMax(rowData).get(0).getString("maxCd");
				rowData.put("setCd", "S"+makeDtlCode(strMaxDtlNum));
				
				// 장례식장내 동일 세트코드 조회(중복 안되면 insert)
				strDupFlag = funeralSaleGoodsInfoMgntDAO.selectMclassDupFlag(rowData).get(0).getString("dupFlag");
				if("N".equals(strDupFlag)) {
					insRowCnt += funeralSaleGoodsInfoMgntDAO.insertMclassGoodsList(rowData);		
			/*	
					for (int j = 0 ; j < sclassList.size() ; j++) {
						Map<String, Object> rowData2 = sclassList.get(i);
						int rowType2 = ((Integer)rowData2.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
					
						//Insert 처리
						if (rowType2 == DataSet.ROW_TYPE_INSERTED) {
							
							// 장례식장,세트별 max detail cd
				//			strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectSclassDtlMax(rowData2).get(0).getString("maxCd");				
				//			rowData2.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
							
							// 장례식장내 동일 코드 조회(중복 안되면 insert)
							strDupFlag = funeralSaleGoodsInfoMgntDAO.selectSclassDupFlag(rowData2).get(0).getString("dupFlag");
							if("N".equals(strDupFlag)) {
								insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSclassGoodsList(rowData2);		
							}
						}
					}
			*/		
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateMclassGoodsList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteMclassGoodsList(rowData);				
			}		
		}
		
		// 세트별 상세 등록
		for (int i = 0 ; i < sclassList.size() ; i++) {
			Map<String, Object> rowData = sclassList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();			
		
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				
				// 장례식장,세트별 max detail cd
		//		strMaxDtlNum = funeralSaleGoodsInfoMgntDAO.selectSclassDtlMax(rowData).get(0).getString("maxCd");				
		//		rowData.put("detailGoodsCd", makeDtlCode(strMaxDtlNum));
				
				// 장례식장내 동일 코드 조회(중복 안되면 insert)
				strDupFlag = funeralSaleGoodsInfoMgntDAO.selectSclassDupFlag(rowData).get(0).getString("dupFlag");
				if("N".equals(strDupFlag)) {
					insRowCnt += funeralSaleGoodsInfoMgntDAO.insertSclassGoodsList(rowData);		
				}
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += funeralSaleGoodsInfoMgntDAO.updateSclassGoodsList(rowData);				
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += funeralSaleGoodsInfoMgntDAO.deleteSclassGoodsList(rowData);				
			}		
		}
		
		return insRowCnt+updRowCnt+delRowCnt;	
	}
}
