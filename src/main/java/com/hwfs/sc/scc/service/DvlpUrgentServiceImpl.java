package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.DvlpUrgentDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개발 긴급 공지하는 DvlpUrgent Service Implementation
 *
 * @ClassName DvlpUrgentServiceImpl.java
 * @Description DvlpUrgentServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/dvlpUrgentService")
public class DvlpUrgentServiceImpl extends DefaultServiceImpl implements DvlpUrgentService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DvlpUrgentDAO Bean 생성 */
	@Resource(name = "/sc/scc/dvlpUrgentDAO")
	private DvlpUrgentDAO dvlpUrgentDAO;


	/**
	 * 개발 긴급 공지 목록을 조회한다.
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
		return dvlpUrgentDAO.selectList(mapParam);
	}

	/**
	 * 개발 긴급 공지 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += dvlpUrgentDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += dvlpUrgentDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += dvlpUrgentDAO.delete(rowData);
			}
		}

		return insRowCnt + updRowCnt + delRowCnt;
	}

	public Object selectRead(Map<String, Object> mapParam) throws Exception {
		return dvlpUrgentDAO.selectRead(mapParam);
	}

	public int saveRead(Map<String, Object> mapParam) throws Exception {
		return dvlpUrgentDAO.insertRead(mapParam);
	}
}
