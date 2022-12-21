package com.hwfs.fs.fsm.service;

import hone.core.util.StringUtils;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.fs.fsm.dao.MachineMstRegDAO;
import com.hwfs.fs.fsm.dao.MachineRequestAllcRtnDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 업장 배장관리하는 MachineRequestAllcRtn Service Implementation
 * 
 * @ClassName MachineRequestAllcRtnServiceImpl.java
 * @Description MachineRequestAllcRtnServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.17    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 김예진
 * @since 2015.03.17
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/fs/fsm/machineRequestAllcRtnService")
public class MachineRequestAllcRtnServiceImpl extends DefaultServiceImpl implements MachineRequestAllcRtnService {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** MachineRequestAllcRtnDAO Bean 생성 */
	@Resource(name = "/fs/fsm/machineRequestAllcRtnDAO")
	private MachineRequestAllcRtnDAO machineRequestAllcRtnDAO;
	
	/** MachineMstRegDAO Bean 생성 */
	@Resource(name = "/fs/fsm/machineMstRegDAO")
	private MachineMstRegDAO machineMstRegDao;
	

	/**
	 * 기기/기물 신청 목록 목록을 조회한다.
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
	public RecordSet selectReqRtnList(Map<String, Object> mapParam) throws Exception {
		return machineRequestAllcRtnDAO.selectReqRtnList(mapParam);
	}
	
	/**
	 * 기기/기물 신청 목록 목록을 조회한다.(이벤트 신청 포함)
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
	public RecordSet selectReqRtnList2(Map<String, Object> mapParam) throws Exception {
		return machineRequestAllcRtnDAO.selectReqRtnList2(mapParam); 
	}

	/**
	 * 기기/기물 신청 목록 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public int saveList(DataSetMap parameter, LoginDTO loginDTO) throws Exception {
		int insRowCnt = 0;
		int updRowCnt = 0;
		int delRowCnt = 0;
		
		for (int i = 0 ; i < parameter.size() ; i++) {
			Map<String, Object> rowData = parameter.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();
			
			int residualQty = 0;
			if(rowType != DataSet.ROW_TYPE_DELETED){
				//동시 신청 잔여수량 체크
				if(StringUtils.isEmpty(rowData.get("firstSignStatus")) || StringUtils.isEmpty(rowData.get("secondSignStatus"))){
					residualQty = machineMstRegDao.selectMachineMstCnt(rowData);
					if(residualQty < Integer.parseInt(rowData.get("requestQuantity").toString())) return -1;
				}
				else if(!(rowData.get("firstSignStatus").toString().equals("003") || rowData.get("secondSignStatus").toString().equals("003")))
				{
					residualQty = machineMstRegDao.selectMachineMstCnt(rowData);
					if(residualQty < Integer.parseInt(rowData.get("requestQuantity").toString())) return -1;
				}
			}
			
						
			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				//rowData.put("loginUpjangCd", loginDTO.getUpjang());
				insRowCnt += machineRequestAllcRtnDAO.insert(rowData);
			}
			//Update 처리
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				updRowCnt += machineRequestAllcRtnDAO.update(rowData);
			}
			//Delete 처리.
			else if (rowType == DataSet.ROW_TYPE_DELETED) {
				delRowCnt += machineRequestAllcRtnDAO.delete(rowData);
			}
		}
				
		return insRowCnt + updRowCnt + delRowCnt;
	}
}
