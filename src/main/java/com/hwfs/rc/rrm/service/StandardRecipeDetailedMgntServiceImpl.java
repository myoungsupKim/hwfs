package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.cmn.util.StringUtil;
import com.hwfs.rc.rrm.dao.StandardRecipeDetailedMgntDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 표준레시피 상세를 관리하는 StandardRecipeDetailedMgnt Service Implementation
 * 
 * @ClassName StandardRecipeDetailedMgntServiceImpl.java
 * @Description StandardRecipeDetailedMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.03    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.04.03
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/standardRecipeDetailedMgntService")
public class StandardRecipeDetailedMgntServiceImpl extends DefaultServiceImpl implements StandardRecipeDetailedMgntService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** StandardRecipeDetailedMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeDetailedMgntDAO")
	private StandardRecipeDetailedMgntDAO standardRecipeDetailedMgntDAO;
	

	/**
	 * 표준레시피 목록을 조회한다.
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
		return standardRecipeDetailedMgntDAO.selectList(mapParam);
	}

	/**
	 * 표준레시피 상세 목록을 조회한다.
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
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedMgntDAO.selectDtlList(mapParam);
	}

	/**
	 * 표준레시피 상세 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap cond, DataSetMap list,DataSetMap dtList, LoginDTO loginDTO) throws Exception
	{
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		// 표준레시피
		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 반찬세트 저장
			if (rowType == DataSet.ROW_TYPE_UPDATED)
			{
				// 대상 레시피를 사용중인 업장 목록을 조회한다.
				RecordSet rs = 	standardRecipeDetailedMgntDAO.selectUpjangList(rowData);				

				//이미지 업로드 저장용
				rowData.put("loginSabun", loginDTO.getSabun());
				updRowCnt += standardRecipeDetailedMgntDAO.updateMst(rowData);
				if( rs != null && rs.size() > 0 )
				{
					for( int n = 0; n < rs.size(); n++ )
					{
						Record record = rs.get(n);
						rowData.put("copyUpjangCd", record.get("upjangCd"));

						updRowCnt += standardRecipeDetailedMgntDAO.updateUpjang(rowData);
					}
				}
				
				logger.debug("rowData " + rowData.toString());
				logger.debug("rowData.get('setRecipeCd') " + rowData.get("setRecipeCd"));
				logger.debug("rowData.get('oldSetRecipeCd') " + rowData.get("oldSetRecipeCd"));

				// 표준레시피상세 삭제
				if( (rowData.get("oldSetRecipeCd") != null || rowData.get("setRecipeCd") == null) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString()) )
				{
					standardRecipeDetailedMgntDAO.setRecipeDelMst(rowData);
					
					if( rs != null && rs.size() > 0 )
					{
						for( int n = 0; n < rs.size(); n++ )
						{
							Record record = rs.get(n);
							rowData.put("copyUpjangCd", record.get("upjangCd"));

							// 업장 반찬세트류를 삭제한다.
							standardRecipeDetailedMgntDAO.setRecipeDelUpjang(rowData);
						}
					}
				}

				// 표준레시피 상세 등록 반찬세트 저장 
				if( rowData.get("setRecipeCd") != null && !"".equals(rowData.get("setRecipeCd").toString()) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString()) )
				{
					standardRecipeDetailedMgntDAO.setRecipeUpdateMst(rowData);

					if( rs != null && rs.size() > 0 )
					{
						for( int n = 0; n < rs.size(); n++ )
						{
							Record record = rs.get(n);
							rowData.put("copyUpjangCd", record.get("upjangCd"));

							// 업장 반찬세트류를 저장한다.
							standardRecipeDetailedMgntDAO.setRecipeUpdateUpjang(rowData);
						}
					}
				}
			}
		}

		int insDtlRowCnt = 0;
		int updDtlRowCnt = 0;
		int delDtlRowCnt = 0;

		for( int i = 0; i < dtList.size(); i++ )
		{
			Map<String, Object> rowData = dtList.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if( rowType == DataSet.ROW_TYPE_INSERTED )
			{
				// 중복체크
				int checkPkCnt = standardRecipeDetailedMgntDAO.selectPkCnt(rowData);

				if( checkPkCnt > 1 )
				{
					throw new BizException("이미 등록된 자재가 존재 합니다.");
				}

				int stdSeq = standardRecipeDetailedMgntDAO.selectSeq(rowData);
				rowData.put("stdSeq", stdSeq);
				
				insDtlRowCnt += standardRecipeDetailedMgntDAO.insert(rowData);
			}

			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED)
			{
				//시작일자 변경(O) 식자재 변경(X)
				if( !StringUtil.isEmpty(rowData.get("orgSdate")) && StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
				{
					//시작일자 수정[표준레시피]
					updDtlRowCnt += standardRecipeDetailedMgntDAO.updateSdate(rowData);

					//종료일자 수정[표준레시피](이전 자재코드가 있을 경우만 수정)
					if( !StringUtil.isEmpty(rowData.get("prvsMaterialCd")) )
					{
						updDtlRowCnt += standardRecipeDetailedMgntDAO.updateEdatePrvsMaterial(rowData);
					}
				}
				//시작일자 변경(O) 식자재 변경(O)
				else if( !StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
				{
					
					//새로등록[표준레시피]
					rowData.put("edate", "29991231");
					rowData.put("prvsMaterialCd", rowData.get("orgMaterialCd"));
					insRowCnt += standardRecipeDetailedMgntDAO.insert(rowData);
					
					//종료일 수정[표준레시피](품목이 새로 등록되는 시작일자 -1)
					updDtlRowCnt += standardRecipeDetailedMgntDAO.updateEdate(rowData);
				}
				//시작일자 변경(X) 식자재 변경(O)
				else if( StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
				{
					// 식자재 변경[표준레시피]
					updDtlRowCnt += standardRecipeDetailedMgntDAO.updateMaterialCd(rowData);
				}
				//시작일자 변경(X) 식자재 변경(X)
				else
				{
					//[표준레시피]
					updDtlRowCnt += standardRecipeDetailedMgntDAO.update(rowData);
				}
			}
			//Delete 처리.
			else if( rowType == DataSet.ROW_TYPE_DELETED )
			{
				delDtlRowCnt += standardRecipeDetailedMgntDAO.delete(rowData);
			}
		}
		
		// 변경 데이터가 있을경우 업장상세 데이터 변경
		if( insDtlRowCnt > 0 || updDtlRowCnt > 0 || delDtlRowCnt > 0 )
		{
			Map<String, Object> rowData = dtList.get(0);

			// 대상 레시피를 사용중인 업장 목록을 조회한다.
			RecordSet rs = 	standardRecipeDetailedMgntDAO.selectUpjangList(rowData);
			
			if( rs != null && rs.size() > 0 )
			{
				// 업장레시피를 삭제한다.
				standardRecipeDetailedMgntDAO.deleteUpjangRecipeDtl(rowData);

				for( int n = 0; n < rs.size(); n++ )
				{
					Record record = rs.get(n);
					rowData.put("copyUpjangCd", record.get("upjangCd"));

					// 업장 레시피를 등록한다.
					standardRecipeDetailedMgntDAO.insertUpjangRecipeDtl(rowData);
				}
			}
		}
		
		// 저장,수정,삭제 처리 후 총 수량 업데이트
		if( dtList.size() > 0 )
		{
			Map<String, Object> rowData = dtList.get(0);
			updDtlRowCnt += standardRecipeDetailedMgntDAO.saveRecipeMstCnt(rowData);
		}

		if( cond.size() > 0 )
		{
			Map<String, Object> condData = cond.get(0);
			
			// 레시피 가져오기로 레시피 저장시 레시피 사진, 조리법 저장

			// 표준
			if( condData.get("orgUpjangCd").equals("") )
				condData.put("saveType", "A");
			// 업장
			else
				condData.put("saveType", "B");	

			if( (condData.get("copyType").equals("A") || condData.get("copyType").equals("C") ) && condData.get("cuisineYn").equals("Y") )
				standardRecipeDetailedMgntDAO.deleteStdRecipeCuisine(condData);

			// 조리법 저장
			standardRecipeDetailedMgntDAO.saveStdRecipeCuisine(condData);

			// 사진
			standardRecipeDetailedMgntDAO.saveStdRecipePic(condData);
		}

		return insRowCnt + updRowCnt + delRowCnt + insDtlRowCnt + updDtlRowCnt + delDtlRowCnt;
	}
	
	/**
	 * 
	 * 레서피 상세 추가시 재료순번 구하기
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public int selectRecipeDtlSortOrder(Map<String, Object> mapParam) throws Exception {
		return standardRecipeDetailedMgntDAO.selectRecipeDtlSortOrder(mapParam);
		
	}
}
