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
import com.hwfs.rc.rrm.dao.SmlRecipeDetailedMgntDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 가상레시피 상세를 관리하는 SmlRecipeDetailedMgnt Service Implementation
 *
 * @ClassName SmlRecipeDetailedMgntServiceImpl.java
 * @Description SmlRecipeDetailedMgntServiceImpl Class
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

@Service("/rc/rrm/smlRecipeDetailedMgntService")
public class SmlRecipeDetailedMgntServiceImpl extends DefaultServiceImpl implements SmlRecipeDetailedMgntService
{
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmlRecipeDetailedMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/smlRecipeDetailedMgntDAO")
	private SmlRecipeDetailedMgntDAO smlRecipeDetailedMgntDAO;


	/**
	 * 가상레시피 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception
	{
		return smlRecipeDetailedMgntDAO.selectList(mapParam);
	}

	/**
	 * 가상레시피 상세 목록을 조회한다.
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
	public RecordSet selectDtlList(Map<String, Object> mapParam) throws Exception
	{
		return smlRecipeDetailedMgntDAO.selectDtlList(mapParam);
	}

	/**
	 * 가상레시피 상세를 Insert/Update/Delete 처리한다.
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

		// 가상레시피 코드
		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// 반찬세트 저장
			if (rowType == DataSet.ROW_TYPE_UPDATED)
			{
				String recipeCd = (String) rowData.get("stdRecipeCd");
				String recipeNm = (String) rowData.get("recipeNm");

				RecordSet rs = smlRecipeDetailedMgntDAO.smlRecipeYn(rowData);
				Record record = rs.get(0);

				String smlRecipeYn = (String) record.get("smlRecipeYn");

				if( smlRecipeYn.equals("N") )
				{
					throw new BizException(recipeNm + "[" + recipeCd + "] 레시피는 표준레시피로 등록되어 수정, 삭제가 불가합니다.");
				}
				else if( smlRecipeYn.equals("D") )
				{
					throw new BizException(recipeNm + "[" + recipeCd + "] 레시피는 삭제된 레시피입니다.");
				}

				rowData.put("loginSabun", loginDTO.getSabun());
				updRowCnt += smlRecipeDetailedMgntDAO.updateMst(rowData);

				logger.debug("rowData " + rowData.toString());
				logger.debug("rowData.get('setRecipeCd') " + rowData.get("setRecipeCd"));
				logger.debug("rowData.get('oldSetRecipeCd') " + rowData.get("oldSetRecipeCd"));

				// 가상레시피 상세 반찬세트 삭제
				if( (rowData.get("oldSetRecipeCd") != null || rowData.get("setRecipeCd") == null) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString()) )
				{
					smlRecipeDetailedMgntDAO.setRecipeDelMst(rowData);
				}

				// 가상레시피 상세 등록 반찬세트 저장
				if( rowData.get("setRecipeCd") != null && !"".equals(rowData.get("setRecipeCd").toString()) && !rowData.get("setRecipeCd").toString().equals(rowData.get("oldSetRecipeCd").toString()) )
				{
					smlRecipeDetailedMgntDAO.setRecipeUpdateMst(rowData);
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
				int checkPkCnt = smlRecipeDetailedMgntDAO.selectPkCnt(rowData);

				if( checkPkCnt > 1 )
				{
					throw new BizException("이미 등록된 자재가 존재 합니다.");
				}

				int stdSeq = smlRecipeDetailedMgntDAO.selectSeq(rowData);
				rowData.put("stdSeq", stdSeq);

				insDtlRowCnt += smlRecipeDetailedMgntDAO.insert(rowData);
			}
			else
			{
				String recipeCd = (String) rowData.get("stdRecipeCd");
				String recipeNm = (String) rowData.get("recipeNm");

				RecordSet rs = smlRecipeDetailedMgntDAO.smlRecipeYn(rowData);
				Record record = rs.get(0);

				String smlRecipeYn = (String) record.get("smlRecipeYn");

				if( smlRecipeYn.equals("N") )
				{
					throw new BizException(recipeNm + "[" + recipeCd + "] 레시피는 표준레시피로 등록되어 수정, 삭제가 불가합니다.");
				}
				else if( smlRecipeYn.equals("D") )
				{
					throw new BizException(recipeNm + "[" + recipeCd + "] 레시피는 삭제된 레시피입니다.");
				}

				// Update 처리
				if( rowType == DataSet.ROW_TYPE_UPDATED )
				{
					// 시작일자 변경(O) 식자재 변경(X)
					if( !StringUtil.isEmpty(rowData.get("orgSdate")) && StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
					{
						// 시작일자 수정
						updDtlRowCnt += smlRecipeDetailedMgntDAO.updateSdate(rowData);

						// 종료일자 수정(이전 자재코드가 있을 경우만 수정)
						if( !StringUtil.isEmpty(rowData.get("prvsMaterialCd")) )
						{
							updDtlRowCnt += smlRecipeDetailedMgntDAO.updateEdatePrvsMaterial(rowData);
						}
					}
					// 시작일자 변경(O) 식자재 변경(O)
					else if( !StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
					{

						// 새로등록
						rowData.put("edate", "29991231");
						rowData.put("prvsMaterialCd", rowData.get("orgMaterialCd"));
						insRowCnt += smlRecipeDetailedMgntDAO.insert(rowData);

						// 종료일 수정(품목이 새로 등록되는 시작일자 -1)
						updDtlRowCnt += smlRecipeDetailedMgntDAO.updateEdate(rowData);
					}
					//시작일자 변경(X) 식자재 변경(O)
					else if( StringUtil.isEmpty(rowData.get("orgSdate")) && !StringUtil.isEmpty(rowData.get("orgMaterialCd")) )
					{
						// 식자재 변경
						updDtlRowCnt += smlRecipeDetailedMgntDAO.updateMaterialCd(rowData);
					}
					// 시작일자 변경(X) 식자재 변경(X)
					else
					{
						updDtlRowCnt += smlRecipeDetailedMgntDAO.update(rowData);
					}
				}
				// Delete 처리.
				else if( rowType == DataSet.ROW_TYPE_DELETED )
				{
					delDtlRowCnt += smlRecipeDetailedMgntDAO.delete(rowData);
				}
			}
		}

		// 저장,수정,삭제 처리 후 총 수량 업데이트
		if( dtList.size() > 0 )
		{
			Map<String, Object> rowData = dtList.get(0);
			updDtlRowCnt += smlRecipeDetailedMgntDAO.saveRecipeMstCnt(rowData);
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
				smlRecipeDetailedMgntDAO.deleteStdRecipeCuisine(condData);

			// 조리법 저장
			smlRecipeDetailedMgntDAO.saveStdRecipeCuisine(condData);

			// 사진
			smlRecipeDetailedMgntDAO.saveStdRecipePic(condData);
		}

		return insRowCnt + updRowCnt + delRowCnt + insDtlRowCnt + updDtlRowCnt + delDtlRowCnt;
	}
}