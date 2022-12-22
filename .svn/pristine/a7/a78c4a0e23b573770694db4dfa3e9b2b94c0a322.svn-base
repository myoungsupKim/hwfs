package com.hwfs.fs.fsa.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsa.dao.AdoptionPoolListDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AddrSearchService;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;


/**
 * 채용인력Pool관리하는 AdoptionPoolList Service Implementation
 * 
 * @ClassName AdoptionPoolListServiceImpl.java
 * @Description AdoptionPoolListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.24    yanghj        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 yanghj
 * @since 2015.03.24
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsa/adoptionPoolListService")
public class AdoptionPoolListServiceImpl extends DefaultServiceImpl implements AdoptionPoolListService {



	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/** AdoptionPoolListDAO Bean 생성 */
	@Resource(name = "/fs/fsa/adoptionPoolListDAO")
	private AdoptionPoolListDAO adoptionPoolListDAO;


	/**
	 * 채용인력Pool관리 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectSido(Map<String, Object> mapParam) throws Exception {
		return adoptionPoolListDAO.selectSido(mapParam);
	}

	/**
	 * 채용인력Pool관리 목록을 조회한다.
	 * <pre>
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return adoptionPoolListDAO.selectList(mapParam);
	}
	
	//주소를 처리하기 위한 공통 Service
		@Resource(name = "/sc/cmn/addrSearchService")
		private AddrSearchService addressService;


	/**
	 * 채용인력Pool관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap list,  DataSetMap fileList, LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;

		//첨부참조일련번호
		String strRefSeq = "";	
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(fileList, propertiesService.getString("fs.file.path"), true);

		//		Map<String, Object> rowData = list.get(0);
		//		int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			// 주소 처리
			Map<String, Object> rtn = addressService.setAddress(rowData, "addrInfo", loginDTO.getSabun());
			
			if (!strRefSeq.equals(""))
			rowData.put("fileId", strRefSeq);
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += adoptionPoolListDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += adoptionPoolListDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += adoptionPoolListDAO.delete(rowData);
			}
			else if (strRefSeq.equals("")) {
				updRowCnt += adoptionPoolListDAO.update(rowData);
			}
		}		
		return insRowCnt + updRowCnt + delRowCnt;

	}
}
