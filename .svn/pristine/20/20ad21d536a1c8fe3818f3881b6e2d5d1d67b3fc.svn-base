package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.rc.rrm.dao.SmlRecipeMasterMgntDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

/**
 * 가상레시피 코드를 관리하는 SmlRecipeMasterMgnt Service Implementation
 *
 * @ClassName SmlRecipeMasterMgntServiceImpl.java
 * @Description SmlRecipeMasterMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.30    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 유인찬
 * @since 2015.03.30
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/rc/rrm/smlRecipeMasterMgntService")
public class SmlRecipeMasterMgntServiceImpl extends DefaultServiceImpl implements SmlRecipeMasterMgntService
{

	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmlRecipeMasterMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/smlRecipeMasterMgntDAO")
	private SmlRecipeMasterMgntDAO smlRecipeMasterMgntDAO;

	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;


	/**
	 * 가상레시피 코드 목록을 조회한다.
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
		return smlRecipeMasterMgntDAO.selectList(mapParam);
	}

	/**
	 * 가상레시피 코드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception
	{
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String stdRecipeCd = "";

		for( int i = 0; i < list.size(); i++ )
		{
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			// Insert 처리
			if( rowType == DataSet.ROW_TYPE_INSERTED )
			{
				// 레시피코드 채번
				stdRecipeCd = (String)smlRecipeMasterMgntDAO.selectMaxStdRecipeCd(rowData);

				rowData.put("stdRecipeCd", stdRecipeCd);

				// 레시피코드 등록
				insRowCnt += smlRecipeMasterMgntDAO.insert(rowData);

				// 가상레피시 관리 등록
				insRowCnt += smlRecipeMasterMgntDAO.insertMgmt(rowData);
			}
			else
			{
				String recipeCd = (String) rowData.get("stdRecipeCd");
				String recipeNm = (String) rowData.get("recipeNm");

				RecordSet rs = smlRecipeMasterMgntDAO.smlRecipeYn(rowData);
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

				//Update 처리
				if (rowType == DataSet.ROW_TYPE_UPDATED)
				{
					updRowCnt += smlRecipeMasterMgntDAO.update(rowData);
				}
				//Delete 처리.
				else if (rowType == DataSet.ROW_TYPE_DELETED)
				{
					delRowCnt += smlRecipeMasterMgntDAO.deleteCuisine(rowData);
					delRowCnt += smlRecipeMasterMgntDAO.deleteDetail(rowData);
					delRowCnt += smlRecipeMasterMgntDAO.deleteMst(rowData);
					delRowCnt += smlRecipeMasterMgntDAO.deleteMgmt(rowData);
				}				
			}

		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 * 레시피 관련 이미지를 저장한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.rrm.service.StandardRecipeMasterMgntService#saveRecipeFile(hone.online.xplatform.map.DataSetMap)
	*/
	public String saveRecipeFile(DataSetMap list) throws Exception
	{
		// 첨부참조일련번호
		String strRefSeq = "";	

		// 첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(list, propertiesService.getString("rc.file.path"), false, true);

		return strRefSeq;
	}

	/**
	 * 반찬 세트류 Combo 데이터 조회
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
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception
	{
		return smlRecipeMasterMgntDAO.selectRsr(mapParam);
	}
}