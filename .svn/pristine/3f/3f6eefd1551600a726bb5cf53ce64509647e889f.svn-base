package com.hwfs.sc.sca.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.XplatformConstants;
import hone.online.xplatform.map.DataSetMap;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.sca.dao.AuthChngRequestDAO;
import com.tobesoft.xplatform.data.DataSet;

 /**
 * 권한변경을 요청하는 AuthChngRequest Service Implementation
 *
 * @ClassName AuthChngRequestServiceImpl.java
 * @Description AuthChngRequestServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.13    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.07.13
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/sca/authChngRequestService")
public class AuthChngRequestServiceImpl extends DefaultServiceImpl implements AuthChngRequestService {

	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** AuthChngRequestDAO Bean 생성 */
	@Resource(name = "/sc/sca/authChngRequestDAO")
	private AuthChngRequestDAO authChngRequestDAO;

    @Resource(name = "sccRoleChgSeqGenSequence")
    private SequenceIdGenService sccRoleChgSeqGenSequence;

	/**
	 * 권한변경 목록을 조회한다.
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
		return authChngRequestDAO.selectList(mapParam);
	}

	@Override
    public Record selectGwDraftMst(Map<String, Object> parameter) throws Exception {
        return authChngRequestDAO.selectGwDraftMst(parameter);
    }


	/**
	 * 권한변경 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
	public long saveList(DataSetMap list) throws Exception {
		long chgSrlnum = 0L;

		for (int i = 0 ; i < list.size() ; i++) {
			Map<String, Object> rowData = list.get(i);
			int rowType = ((Integer)rowData.get(XplatformConstants.DATASET_ROW_TYPE)).intValue();

			//Insert 처리
			if (rowType == DataSet.ROW_TYPE_INSERTED) {
				chgSrlnum = Long.parseLong(sccRoleChgSeqGenSequence.getNextStringId().trim());
				rowData.put("chgSrlnum", chgSrlnum);
				authChngRequestDAO.insert(rowData);
			}
			else if (rowType == DataSet.ROW_TYPE_UPDATED) {
				chgSrlnum = Long.parseLong(rowData.get("chgSrlnum").toString());
				authChngRequestDAO.update(rowData);
			}
		}

		return chgSrlnum;
	}

	/**
     * 상신 후 instanceId를 저장 한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.sc.scu.service.UserRoleChngService#saveGwInstanceId(java.util.Map)
    */
    @Override
    public int saveGwInstanceId(Map<String, Object> parameter) throws Exception {
        return authChngRequestDAO.saveGwInstanceId(parameter);
    }
}
