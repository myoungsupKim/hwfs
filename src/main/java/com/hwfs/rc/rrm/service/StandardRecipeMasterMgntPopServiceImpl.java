package com.hwfs.rc.rrm.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeMasterMgntPopDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 표준 레시피 조리법을 관리하는 StandardRecipeMasterMgntPop Service Implementation
 * 
 * @ClassName StandardRecipeMasterMgntPopServiceImpl.java
 * @Description StandardRecipeMasterMgntPopServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.01    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.01
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/standardRecipeMasterMgntPopService")
public class StandardRecipeMasterMgntPopServiceImpl extends DefaultServiceImpl implements StandardRecipeMasterMgntPopService {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** StandardRecipeMasterMgntPopDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeMasterMgntPopDAO")
	private StandardRecipeMasterMgntPopDAO standardRecipeMasterMgntPopDAO;
	

	/**
	 * 표준 레시피 조리법 목록을 조회한다.
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
		return standardRecipeMasterMgntPopDAO.selectList(mapParam);
	}

	/**
	 * 표준 레시피 조리법 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list, Map<String, Object> mapParam) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String sml_yn = "";
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += standardRecipeMasterMgntPopDAO.insert(rowData);
				
				//가상레시피인 경우 SKIP되도록 수정 2017.07.14 김호석				
				if (mapParam.get("smlYn").equals("Y")) { 
					//SKIP
				} else {
					//일괄등록을 위한 업장코드검색
					RecordSet rs = standardRecipeMasterMgntPopDAO.selectListUpjangCd(rowData);
					if(rs != null && rs.size() > 0){
						for(int j=0; j<rs.size(); j++){
							rowData.put("upjangCd", rs.get(j).get("upjangCd"));
							
							//새로 추가하는 조리법 업장에 등록
							if(rowData.get("upjangModifyAllowYn").equals("N")){
								insRowCnt += standardRecipeMasterMgntPopDAO.insertUpjangRecipeCuisine(rowData);
							}
						}
					}
				}
				
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += standardRecipeMasterMgntPopDAO.update(rowData);
				//가상레시피인 경우 SKIP되도록 수정 2017.07.14 김호석 
				if (mapParam.get("smlYn").equals("Y")) {
					//SKIP
				} else {
					//업장조리법 일괄수정
					//일괄등록을 위한 업장코드검색
					RecordSet rs = standardRecipeMasterMgntPopDAO.selectListUpjangCd(rowData);
					if(rs != null && rs.size() > 0){
						for(int j=0; j<rs.size(); j++){
							rowData.put("upjangCd", rs.get(j).get("upjangCd"));
							
							if(rowData.get("upjangModifyAllowYn").equals("N")){
								updRowCnt += standardRecipeMasterMgntPopDAO.updateUpjangRecipeCuisine(rowData);
							}
						}
					}
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += standardRecipeMasterMgntPopDAO.delete(rowData);
				delRowCnt += standardRecipeMasterMgntPopDAO.delete2(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
