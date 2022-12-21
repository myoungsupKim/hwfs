package com.hwfs.fs.fso.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fso.dao.BidMgntDAO;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 입찰을 관리하는 BidMgnt Service Implementation
 * 
 * @ClassName BidMgntServiceImpl.java
 * @Description BidMgntServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.04.29
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fso/bidMgntService")
public class BidMgntServiceImpl extends DefaultServiceImpl implements BidMgntService {

	/** BidMgntDAO Bean 생성 */
	@Resource(name = "/fs/fso/bidMgntDAO")
	private BidMgntDAO bidMgntDAO;
	
	/** AttachFile Service Bean 생성 */
	@Resource(name = "/sc/cmn/attachFileService")
	private AttachFileService attachFileService;

	/**
	 * 입찰관리 목록을 조회한다.
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
	public RecordSet selectMuNm(Map<String, Object> mapParam) throws Exception {
		return bidMgntDAO.selectMuNm(mapParam);
	}
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return bidMgntDAO.selectList(mapParam);
	}

	/**
	 * 입찰관리 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameterBid, DataSetMap paramFileList) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		//첨부참조일련번호
		String strRefSeq = "";	
		//첨부파일 처리 : 업무별 저장소의 상대패스를 파라미터로 전달해야 한다.
		strRefSeq = attachFileService.save(paramFileList, propertiesService.getString("fs.file.path"), true);
						
		for (int i = 0 ; i < parameterBid.size() ; i++) {
			Map<String, Object> rowData = parameterBid.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			if (!"".equals(strRefSeq))
				rowData.put("fileId", strRefSeq);
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				insRowCnt += bidMgntDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += bidMgntDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += bidMgntDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
