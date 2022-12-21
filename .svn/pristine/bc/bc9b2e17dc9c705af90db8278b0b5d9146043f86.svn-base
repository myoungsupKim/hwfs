package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.ObjectMngtCardDAO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sc.cmn.util.ValidationUtil;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 물건관리카드하는 ObjectMngtCard Service Implementation
 * 
 * @ClassName ObjectMngtCardServiceImpl.java
 * @Description ObjectMngtCardServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.26    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최문규
 * @since 2015.05.26
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/objectMngtCardService")
public class ObjectMngtCardServiceImpl extends DefaultServiceImpl implements ObjectMngtCardService {
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;
	
	//주소를 처리하기 위한 공통 Service
	@Resource(name = "/sc/cmn/addrSearchService")
	private AddrSearchService addressService;
	
	/** ObjectMngtCardDAO Bean 생성 */
	@Resource(name = "/fs/fso/objectMngtCardDAO")
	private ObjectMngtCardDAO objectMngtCardDAO;

	/**
	 * 물건관리카드 계약만료 팝업을 조회한다.
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
	public RecordSet selectObjectMngtCardRunOutList(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectObjectMngtCardRunOutList(mapParam);
	}
	
	/**
	 * 물건관리카드 등록대상 고객사팝업을 조회한다.
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
	public RecordSet selectObjectMngtCardRegPopup(Map<String, Object> mapParam) throws Exception {
		
		if("A".equals(mapParam.get("searchType"))) {
			return objectMngtCardDAO.selectObjectMngtCardRegPopup1(mapParam);
		}else {
			return objectMngtCardDAO.selectObjectMngtCardRegPopup2(mapParam);
		}
	}
	
	/**
	 * Combo 코드목록을 조회한다.
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
	public Map<String, RecordSet> selectCode(Map<String, Object> mapParam) throws Exception {
// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
		String muCd                   = mapParam.get("muCd").toString();
		String tmCd                   = mapParam.get("tmCd").toString();
		String orgMuCd                = mapParam.get("orgMuCd").toString();
		String orgTmCd                = mapParam.get("orgTmCd").toString();
		String tgrYn                  = "N";
		RecordSet rs_tgrYn            = null;

		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// FS사업부일 경우 팀장여부 조회
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			rs_tgrYn = objectMngtCardDAO.searchTgrYn(mapParam);
			
			if ( rs_tgrYn.getRowCount() > 0 ) {
				tgrYn = rs_tgrYn.get(0).getString("tgrYn");
			}
			mapParam.put("tgrYn", tgrYn);
		}
		
		RecordSet rs1 = objectMngtCardDAO.selectPrcgEmpCd(mapParam);
/* 2018.10.12 김명섭 조건 체크 주석처리
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 사업부가 FS사업부일 경우
		if ( ValidationUtil.isEquals(orgMuCd, "2002") ) {
			// 자신이 속한 팀이외는 리턴값 없음
			if ( !ValidationUtil.isEquals(tmCd, orgTmCd) ) {
				rs1.clear();
			}
			
		// 사업부가 FS사업부가 아닐 경우
		} else {
			// 사업부를 FS사업부로 선택했을 경우
			if ( ValidationUtil.isEquals(muCd, "2002") ) {
				rs1.clear();
			}
		}
2018.10.12 김명섭 조건 체크 주석처리 */
// [속도개선 Project   끝] 2017. 7. 21. 최범주
		RecordSet rs2 = objectMngtCardDAO.selectLocCode(mapParam);
		RecordSet rs3 = objectMngtCardDAO.selectJobCode(mapParam);
		RecordSet rs4 = objectMngtCardDAO.selectOpVendor(mapParam);
		RecordSet rs5 = objectMngtCardDAO.selectPrcgDept(mapParam);
		
		RecordSet rs6 = objectMngtCardDAO.selectJobClassCode(mapParam);
		RecordSet rs7 = objectMngtCardDAO.selectJobMClassCode(mapParam);
		RecordSet rs8 = objectMngtCardDAO.selectJobSClassCode(mapParam);

		RecordSet rs9 = objectMngtCardDAO.selectLocCode2(mapParam);
		
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("empCd", rs1);
		rsMap.put("loc", rs2);
		rsMap.put("job", rs3);
		rsMap.put("opVendor", rs4);
		rsMap.put("dept", rs5);
		
		rsMap.put("jobClass", rs6);
		rsMap.put("jobMClass", rs7);
		rsMap.put("jobSClass", rs8);

		rsMap.put("loc2", rs9);
		
		return rsMap;
	}

	/**
	 * 물건목록을 조회한다.
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
	public RecordSet selectObjectList(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectObjectList(mapParam);
	}
	
	/**
	 * 물건정보 상세를 조회한다.
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
	public Map<String, RecordSet> selectDetail(Map<String, Object> mapParam) throws Exception {
				
		RecordSet rs1 = objectMngtCardDAO.selectObjectDetail(mapParam);
		RecordSet rs2 = objectMngtCardDAO.selectObjectMealUprice(mapParam);
		RecordSet rs3 = objectMngtCardDAO.selectObjectUpjang(mapParam);
				
		Map<String, RecordSet> rsMap = new HashMap<String, RecordSet>();
		rsMap.put("detail", rs1);
		rsMap.put("uprice", rs2);
		rsMap.put("upjang", rs3);
		
		return rsMap;
	}
	
	/**
	 * 로그인 사용자의 부서, 사번을 조회한다.
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
	public RecordSet selectEmpMarketer(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectEmpMarketer(mapParam);
	}

	/**
	 * 지역코드 2를 조회한다.
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
	public RecordSet selectLocCd2(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectLocCd2(mapParam);
	}	

	/**
	 * 지역코드상세all 조회한다.
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
	public RecordSet selectLocCd2All(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectLocCd2All(mapParam);
	}	

	/**
	 * 지역코드 2를 조회한다.
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
	public RecordSet selectSearchLocCd2(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.selectSearchLocCd2(mapParam);
	}	
	
	/**
	 * 물건관리카드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public String saveObjectMngtCard(DataSetMap listObjMngtCard, DataSetMap listObjMealUprice, DataSetMap listObjectUpjang, DataSetMap listFile, String sabun) throws Exception {
		
		String rtnObjCd = null;		
		String strRefSeq = "";	//첨부참조일련번호
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("fs.file.path"), false, false);
		
		if(listObjMngtCard.size()>0) {
			
			for (int i = 0 ; i < listObjMngtCard.size() ; i++) {
				Map<String, Object> rowData = listObjMngtCard.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				rowData.put("seq", 1);
				rowData.put("fileId", strRefSeq);
				
				//주소 처리
				Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", sabun);
				
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					objectMngtCardDAO.insertObjMngtCard(rowData);
					// 입력된 seq 값을 조회
					rtnObjCd = objectMngtCardDAO.selectObjectCode(rowData).getRecord(0).get("objectCd").toString();
					
					for (int j = 0 ; j < listObjMealUprice.size() ; j++) {
						Map<String, Object> rowData2 = listObjMealUprice.get(j);
						rowType = ((Integer)rowData2.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType == DataSet.ROW_TYPE_INSERTED) {						
							rowData2.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjMealUprice(rowData2);
						}
					}
					
					for (int k = 0 ; k < listObjectUpjang.size() ; k++) {
						Map<String, Object> rowData3 = listObjectUpjang.get(k);
						rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType == DataSet.ROW_TYPE_INSERTED) {
							rowData3.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjUpjang(rowData3);
						}
					}				
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					
					objectMngtCardDAO.updateObjMngtCard(rowData);
					rtnObjCd = rowData.get("objectCd").toString();
					
					for (int j = 0 ; j < listObjMealUprice.size() ; j++) {
						Map<String, Object> rowData2 = listObjMealUprice.get(j);
						rowType = ((Integer)rowData2.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType == DataSet.ROW_TYPE_INSERTED) {						
							rowData2.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjMealUprice(rowData2);
						}
						//Update 처리
						else if (rowType == DataSet.ROW_TYPE_UPDATED) {
							objectMngtCardDAO.updateObjMealUprice(rowData2);
						}
						//Delete 처리.
						else if (rowType == DataSet.ROW_TYPE_DELETED) {
							objectMngtCardDAO.deleteObjMealUprice(rowData2);
						}
					}
					
					for (int k = 0 ; k < listObjectUpjang.size() ; k++) {
						Map<String, Object> rowData3 = listObjectUpjang.get(k);
						rowType = ((Integer)rowData3.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType == DataSet.ROW_TYPE_INSERTED) {
							rowData3.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjUpjang(rowData3);
						}
						//Update 처리
						else if (rowType == DataSet.ROW_TYPE_UPDATED) {
							objectMngtCardDAO.updateObjUpjang(rowData3);
						}
						//Delete 처리.
						else if (rowType == DataSet.ROW_TYPE_DELETED) {
							objectMngtCardDAO.deleteObjUpjang(rowData3);
						}
					}
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
					
					rtnObjCd = rowData.get("objectCd").toString();
					
					for (int j = 0 ; j < listObjMealUprice.size() ; j++) {
						Map<String, Object> rowData2 = listObjMealUprice.get(j);
						rowData2.put("objectCd", rtnObjCd);
						objectMngtCardDAO.deleteObjMealUprice(rowData2);
					}
					
					for (int k = 0 ; k < listObjectUpjang.size() ; k++) {
						Map<String, Object> rowData3 = listObjectUpjang.get(k);
						rowData3.put("objectCd", rtnObjCd);
						
						objectMngtCardDAO.deleteObjUpjang(rowData3);
					}
					
					objectMngtCardDAO.deleteObjMngtCard(rowData);
					// 물건관리 카드 삭제할때 등록한 마케터배부도 같이 삭제 처리
					objectMngtCardDAO.deleteObjMngtCardMarketer(rowData);
					
					
				}
				// Normal 일떄, 기타 처리
				else {
					
					rtnObjCd = rowData.get("objectCd").toString();
					for (int k = 0 ; k < listObjMealUprice.size() ; k++) {
						Map<String, Object> rowData2 = listObjMealUprice.get(k);
						int rowType2 = ((Integer)rowData2.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType2 == DataSet.ROW_TYPE_INSERTED) {
							
							rowData2.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjMealUprice(rowData2);
						}
						//Update 처리
						else if (rowType2 == DataSet.ROW_TYPE_UPDATED) {
							objectMngtCardDAO.updateObjMealUprice(rowData2);
						}
						//Delete 처리.
						else if (rowType2 == DataSet.ROW_TYPE_DELETED) {
							objectMngtCardDAO.deleteObjMealUprice(rowData2);
						}
					}
					
					for (int h = 0 ; h < listObjectUpjang.size() ; h++) {
						Map<String, Object> rowData3 = listObjectUpjang.get(h);
						int rowType3 = ((Integer)rowData3.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
						
						//Insert 처리
						if (rowType3 == DataSet.ROW_TYPE_INSERTED) {
							rowData3.put("objectCd", rtnObjCd);
							objectMngtCardDAO.insertObjUpjang(rowData3);
						}
						//Update 처리
						else if (rowType3 == DataSet.ROW_TYPE_UPDATED) {
							objectMngtCardDAO.updateObjUpjang(rowData3);
						}
						//Delete 처리.
						else if (rowType3 == DataSet.ROW_TYPE_DELETED) {
							objectMngtCardDAO.deleteObjUpjang(rowData3);
						}
					}
				}
			}
			
		}else {
		
			for (int i = 0 ; i < listObjMealUprice.size() ; i++) {
				Map<String, Object> rowData = listObjMealUprice.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					
					rowData.put("objectCd", rtnObjCd);
					objectMngtCardDAO.insertObjMealUprice(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					objectMngtCardDAO.updateObjMealUprice(rowData);
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
					objectMngtCardDAO.deleteObjMealUprice(rowData);
				}
			}
			
			for (int i = 0 ; i < listObjectUpjang.size() ; i++) {
				Map<String, Object> rowData = listObjectUpjang.get(i);
				int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
				
				//Insert 처리
				if (rowType == DataSet.ROW_TYPE_INSERTED) {
					rowData.put("objectCd", rtnObjCd);
					objectMngtCardDAO.insertObjUpjang(rowData);
				}
				//Update 처리
				else if (rowType == DataSet.ROW_TYPE_UPDATED) {
					objectMngtCardDAO.updateObjUpjang(rowData);
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED) {
					objectMngtCardDAO.deleteObjUpjang(rowData);
				}
			}
		}		
		return strRefSeq;
	}

// [속도개선 Project 시작] 2017. 7. 21. 최범주 사용자가 FS사업부일 경우 담당마케터 콤보 셋팅 기능 추가
	/**
	 * 팀장여부 조회
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
	public RecordSet searchTgrYn(Map<String, Object> mapParam) throws Exception {
		return objectMngtCardDAO.searchTgrYn(mapParam);
	}
// [속도개선 Project   끝] 2017. 7. 21. 최범주

	@SuppressWarnings("unchecked")
	public int chgangeObjectMngtCard(DataSetMap list) throws Exception {
		int updRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Update 처리
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += objectMngtCardDAO.changeObjMngtCard(rowData);

			}
		}
				
		return updRowCnt;
	}
}
