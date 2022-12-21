package com.hwfs.sc.scp.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scp.dao.PersDstryHistDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 개인정보 파기이력을 관리하는 PersDstryHist Service Implementation
 * 
 * @ClassName PersDstryHistServiceImpl.java
 * @Description PersDstryHistServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.20
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scp/persDstryHistService")
public class PersDstryHistServiceImpl extends DefaultServiceImpl implements PersDstryHistService {
	
	/** PersDstryHistDAO Bean 생성 */
	@Resource(name = "/sc/scp/persDstryHistDAO")
	private PersDstryHistDAO persDstryHistDAO;
	

	/**
	 * 개인정보 파기이력 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return persDstryHistDAO.selectList(mapParam);
	}

	/**
	 * 개인정보 파기이력 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
				insRowCnt += persDstryHistDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += persDstryHistDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += persDstryHistDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
	
	/**
	 * 사용자 지속이용 표명으로 인한 개인정보 파기통보 건을 취소처리한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int cancelDstryNoti(Map<String, Object> mapParam) throws Exception {
		return persDstryHistDAO.cancelDstryNoti(mapParam);
	}
}
