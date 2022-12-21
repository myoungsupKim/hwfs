package com.hwfs.rc.rrm.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.rc.rrm.dao.StandardRecipeMasterMgntDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 표준레시피 코드를 관리하는 StandardRecipeMasterMgnt Service Implementation
 *
 * @ClassName StandardRecipeMasterMgntServiceImpl.java
 * @Description StandardRecipeMasterMgntServiceImpl Class
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
@Service("/rc/rrm/standardRecipeMasterMgntService")
public class StandardRecipeMasterMgntServiceImpl extends DefaultServiceImpl implements StandardRecipeMasterMgntService {

	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** StandardRecipeMasterMgntDAO Bean 생성 */
	@Resource(name = "/rc/rrm/standardRecipeMasterMgntDAO")
	private StandardRecipeMasterMgntDAO standardRecipeMasterMgntDAO;

	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;


	/**
	 * 표준레시피 코드 목록을 조회한다.
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
		return standardRecipeMasterMgntDAO.selectList(mapParam);
	}

	/**
	 * 표준레시피 코드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int save(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String stdRecipeCd = "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				stdRecipeCd = (String)standardRecipeMasterMgntDAO.selectMaxStdRecipeCd(rowData);
				rowData.put("stdRecipeCd", stdRecipeCd);
				insRowCnt += standardRecipeMasterMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += standardRecipeMasterMgntDAO.update(rowData);

				//업장 레시피 일괄수정
				//if(rowData.get("upjangModifyAllowYn").equals("N")){
					updRowCnt += standardRecipeMasterMgntDAO.updateUpjangRecipeMst(rowData);
				//}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += standardRecipeMasterMgntDAO.deleteDetail(rowData);
				delRowCnt += standardRecipeMasterMgntDAO.deleteMst(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	/**
	 *
	 * 표준 레시피 파일 저장
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 */
	/**
	 * saveRecipeFile 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.rc.rrm.service.StandardRecipeMasterMgntService#saveRecipeFile(hone.online.xplatform.map.DataSetMap)
	*/
	public String saveRecipeFile(DataSetMap list) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호

		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(list, propertiesService.getString("rc.file.path"), false, true);

		return strRefSeq;
	}

	/**
	 * 표준레시피 코드 목록을 조회한다.
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
	public RecordSet selectRsr(Map<String, Object> mapParam) throws Exception {
		return standardRecipeMasterMgntDAO.selectRsr(mapParam);
	}

	/**
	 * 표준레시피 코드 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		String stdRecipeCd = "";

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				stdRecipeCd = (String)standardRecipeMasterMgntDAO.selectMaxStdRecipeCd(rowData);
				rowData.put("stdRecipeCd", stdRecipeCd);
				insRowCnt += standardRecipeMasterMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED)
			{
				// 표준레시피 수정
				updRowCnt += standardRecipeMasterMgntDAO.update(rowData);

				// 대상 레시피를 사용중인 업장 목록을 조회한다.
				RecordSet rs = 	standardRecipeMasterMgntDAO.selectUpjangList(rowData);
				
				// 업장레시피를 삭제한다.
//				standardRecipeMasterMgntDAO.deleteUpjangRecipeDtl(rowData);
				standardRecipeMasterMgntDAO.deleteUpjangRecipeMst(rowData);
				
				if( rs != null && rs.size() > 0 )
				{
					for( int n = 0; n < rs.size(); n++ )
					{
						Record record = rs.get(n);
						rowData.put("copyUpjangCd", record.get("upjangCd"));

						// 업장 레시피를 등록한다.
						standardRecipeMasterMgntDAO.insertUpjangRecipeMst(rowData);
//						standardRecipeMasterMgntDAO.insertUpjangRecipeDtl(rowData);
					}
				}
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED)
			{
				delRowCnt += standardRecipeMasterMgntDAO.deleteUpjangRecipeDtl(rowData);
				delRowCnt += standardRecipeMasterMgntDAO.deleteUpjangRecipeMst(rowData);
				delRowCnt += standardRecipeMasterMgntDAO.deleteDetail(rowData);
				delRowCnt += standardRecipeMasterMgntDAO.deleteMst(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}
}