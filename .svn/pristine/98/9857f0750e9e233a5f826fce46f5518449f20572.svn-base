package com.hwfs.sc.scc.service;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.scc.dao.OpLogDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 운영로그 내역을 관리하는 OpLog Service Implementation
 * 
 * @ClassName OpLogServiceImpl.java
 * @Description OpLogServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.13    kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015.05.13
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scc/opLogService")
public class OpLogServiceImpl extends DefaultServiceImpl implements OpLogService {
	
	/** OpLogDAO Bean 생성 */
	@Resource(name = "/sc/scc/opLogDAO")
	private OpLogDAO opLogDAO;
	

	/**
	 * 운영로그 내역 목록을 조회한다.
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return opLogDAO.selectList(mapParam);
	}

	/**
	 * 운영로그 내역 DataSetMap의 데이터를 rowType에 따라 Delete 처리한다.
	 * <pre>
	 * - (참고)스케쥴러에 의해 주기적으로 삭제된다.
	 * </pre>
	 *
	 * @param list
	 *            DataSetMap XPLATFORM에서 전달된 Dataset 데이터
	 * @return 처리건수
	 * @throws Exception
	*/
	@SuppressWarnings("unchecked")
	public int saveList(DataSetMap list) throws Exception {
		int delRowCnt = 0;
		
		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			//Delete 처리.
			if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += opLogDAO.delete(rowData);
			}
		}
				
		return delRowCnt;
	}

	/**
	 * 사용자별 운용로그 데이터를 주기적으로 삭제한다.
	 * <pre>
	 * - DeleteOpLogSchdJob에서 주기적으로 호출한다.
	 * - 전일 로그 데이터를 모두 삭제한다.
	 * </pre>
	 *
	 * @return 처리건수
	 * @throws Exception
	 */
	public int deleteOpLog() throws Exception {
//		 //기준시간을 얻는다. 전일로 한다.
//		Calendar calendar = Calendar.getInstance();
//		calendar.add(java.util.Calendar.DAY_OF_YEAR, -1);
//		Locale currentLocale = new Locale("KOREAN", "KOREA");
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd", currentLocale);
//        String strUseDate = formatter.format(calendar.getTime());
        
        Map<String, Object> mapParam = new HashMap<String, Object>();
//        mapParam.put("useDtm", strUseDate); //SQL로 처리하므로 전달하지 않음
		return opLogDAO.deleteDayBefore(mapParam);
	}

}
