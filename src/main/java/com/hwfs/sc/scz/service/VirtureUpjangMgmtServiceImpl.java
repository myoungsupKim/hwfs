package com.hwfs.sc.scz.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scz.dao.VirtureUpjangMgmtDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 가상 업장을 관리하는 VirtureUpjangMgmt Service Implementation
 * 
 * @ClassName VirtureUpjangMgmtServiceImpl.java
 * @Description VirtureUpjangMgmtServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.08.11    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.08.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/virtureUpjangMgmtService")
public class VirtureUpjangMgmtServiceImpl extends DefaultServiceImpl implements VirtureUpjangMgmtService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** VirtureUpjangMgmtDAO Bean 생성 */
	@Resource(name = "/sc/scz/virtureUpjangMgmtDAO")
	private VirtureUpjangMgmtDAO virtureUpjangMgmtDAO;
	
	@Resource(name="stUpjangSeqGenSequence")
	private SequenceIdGenService stUpjangSeqGenSequence;

	/**
	 * 조직 정보를 조회한다.
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
	public RecordSet selectOrgList(Map<String, Object> mapParam) throws Exception {
		return virtureUpjangMgmtDAO.selectOrgList(mapParam);
	}
	
	/**
	 * 가상 업장 목록을 조회한다.
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
		return virtureUpjangMgmtDAO.selectList(mapParam);
	}

	/**
	 * 가상 업장 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				rowData.put("upjang", BigDecimal.valueOf(Long.parseLong(stUpjangSeqGenSequence.getNextStringId().trim())));
				
				insRowCnt += virtureUpjangMgmtDAO.insertStUpjang(rowData);
				insRowCnt += virtureUpjangMgmtDAO.insertScoUpjangMst(rowData);
				insRowCnt += virtureUpjangMgmtDAO.insertFmsUpjang(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += virtureUpjangMgmtDAO.updateStUpjang(rowData);
				updRowCnt += virtureUpjangMgmtDAO.updateScoUpjangMst(rowData);
				updRowCnt += virtureUpjangMgmtDAO.updateFmsUpjang(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += virtureUpjangMgmtDAO.deleteStUpjang(rowData);
				delRowCnt += virtureUpjangMgmtDAO.deleteScoUpjangMst(rowData);
				delRowCnt += virtureUpjangMgmtDAO.deleteFmsUpjang(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
