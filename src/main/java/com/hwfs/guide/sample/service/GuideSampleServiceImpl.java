package com.hwfs.guide.sample.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.guide.sample.dao.GuideSampleDAO;
import com.hwfs.guide.sample.dto.GuideSampleDTO;
import com.hwfs.sc.cmn.dao.GwIfDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * GuideSampleServiceImpl에 대한 설명 작성
 * @ClassName GuideSampleServiceImpl.java
 * @Description GuideSampleServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.01.22.   김재섭       최초생성
 *  2015.02.02.   kksoo        첨부파일 추가
 *  2015.03.24.   kksoo        전자결재 연동 추가
 * </pre>
 * @author FC종합전산구축 : 공통 김재섭
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/guide/sample/guideSampleService")
public class GuideSampleServiceImpl extends DefaultServiceImpl implements GuideSampleService {

	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/** Guide Sample DAO */
	@Resource(name="/guide/sample/guideSampleDAO")
	private GuideSampleDAO guideSampleDAO;

	/** GwIfDAO Bean 생성 */
	@Resource(name = "/sc/cmn/gwIfDAO")
	private GwIfDAO gwIfDAO;

	/**
	 * GUIDE_SAMPLE의 DATA를 조회한다.
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return guideSampleDAO.selectList(parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가/변경/삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#insertList(hone.online.xplatform.map.DataSetMap)
	*/
	@SuppressWarnings("unchecked")
	@Override
	public int saveList(DataSetMap list) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insertRowCnt += guideSampleDAO.insert(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += guideSampleDAO.update(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				deleteRowCnt += guideSampleDAO.delete(rowData);
			}
		}

		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}

    /**
     * XPLATFORM DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
     * <pre>
     * - 데이터와 첨부파일을 함께 처리한다.
     * </pre>
     *
     * @param list 데이터
     * @parma listFile 첨부파일 정보
     * @param loginDTO 로그인 DTO
     * @return 첨부참조일련번호
     * @throws Exception
     */
	@SuppressWarnings({ "unchecked", "unused" })
	public String saveAttachFile(DataSetMap list, DataSetMap listFile) throws Exception {
		String strRefSeq = "";	//첨부참조일련번호

		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(listFile, propertiesService.getString("sample.path"), false);

		int intCnt=0;
		//데이터 저장 처리
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			//첨부참조일련번호 설정
			if (!strRefSeq.equals(""))
				map.put("refSeq", strRefSeq);

			int rowType = ((Integer) map.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			if ( rowType == DataSet.ROW_TYPE_INSERTED ){
				intCnt += guideSampleDAO.insert(map);
			}else if (rowType == DataSet.ROW_TYPE_UPDATED){
				intCnt += guideSampleDAO.update(map);
			}else if (rowType == DataSet.ROW_TYPE_DELETED){
				intCnt += guideSampleDAO.delete(map);
			}else if (!strRefSeq.equals("")) {
				//(주의)나머지 rowType인 경우 첨부참조일련번호가 새로 채번된 경우 Update하도록 함
				intCnt += guideSampleDAO.update(map);
			}
		}

		return strRefSeq;
	}

	/**
	 * GUIDE_SAMPLE의 DATA를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#selectList(java.util.Map)
	*/
	@Override
	public RecordSet selectListDTO(GuideSampleDTO parameter) throws Exception {
		return guideSampleDAO.selectListDTO(parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가/변경/삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param loginParameter
	 * @param insertParameter
	 * @param updateParameter
	 * @param deleteParameter
	 * @return
	 * @see com.hwfs.sc.template.service.GuideSampleService#saveListDTO(com.hwfs.sc.cmn.dto.LoginDTO, java.util.List, java.util.List, java.util.List)
	*/
	@Override
	public int saveListDTO(
			LoginDTO loginParameter,
			List<GuideSampleDTO> insertParameter,
			List<GuideSampleDTO> updateParameter,
			List<GuideSampleDTO> deleteParameter) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;

		//추가를 수행합니다.
		for (int i = 0 ; i < insertParameter.size() ; i++) {
			GuideSampleDTO parameter = insertParameter.get(i);
			parameter.setCuser(loginParameter.getSabun());
			parameter.setUuser(loginParameter.getSabun());

			insertRowCnt += guideSampleDAO.insertDTO(parameter);
		}

		//수정을 수행합니다.
		for (int i = 0 ; i < updateParameter.size() ; i++) {
			GuideSampleDTO parameter = updateParameter.get(i);
			parameter.setCuser(loginParameter.getSabun());
			parameter.setUuser(loginParameter.getSabun());

			updateRowCnt += guideSampleDAO.updateDTO(parameter);
		}

		//삭제를 수행합니다.
		for (int i = 0 ; i < deleteParameter.size() ; i++) {
			GuideSampleDTO parameter = deleteParameter.get(i);
			parameter.setCuser(loginParameter.getSabun());
			parameter.setUuser(loginParameter.getSabun());

			deleteRowCnt += guideSampleDAO.deleteDTO(parameter);
		}

		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}




	/**
	 * selectCcsTempList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#selectCcsTempList(java.util.Map)
	*/
	@Override
	public RecordSet selectCcsTempList(Map<String, Object> parameter)
			throws Exception {
		return guideSampleDAO.selectCcsTempList(parameter);
	}

	/**
	 * saveCcsTempList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveCcsTempList(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int saveCcsTempList(DataSetMap parameter) throws Exception {
		int insertRowCnt = 0;
		int updateRowCnt = 0;
		int deleteRowCnt = 0;

		for (int i = 0 ; i < parameter.size() ; i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//추가를 수행합니다.
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insertRowCnt += guideSampleDAO.insertCcsTempList(rowData);
			}
			//수정을 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updateRowCnt += guideSampleDAO.updateCcsTempList(rowData);
			}
			//삭제를 수행합니다.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				deleteRowCnt += guideSampleDAO.deleteCcsTempList(rowData);
			}
		}

		return insertRowCnt + updateRowCnt + deleteRowCnt;
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param list
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#saveSign(hone.online.xplatform.map.DataSetMap)
	*/
	@Override
	public int saveSignInfo(DataSetMap list) throws Exception {
		int updateRowCnt = 0;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//수정을 수행합니다. (Update만 존재)
			if (rowType == DataSet.ROW_TYPE_UPDATED) {
				//업무 테이블에 결재INSTANCE_ID update
				updateRowCnt += guideSampleDAO.updateSign(rowData);

				//SCC_SIGN_INFO 테이블에 결재정보저장 (Insert or Update)
				gwIfDAO.saveSignInfo(rowData);
			}
		}

		return updateRowCnt;
	}

	/**
	 * selectOrg 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 * @throws Exception
	 * @see com.hwfs.guide.sample.service.GuideSampleService#selectOrg()
	*/
	@Override
	public RecordSet selectOrg() throws Exception {
		return guideSampleDAO.selectOrg();
	}

}
