package com.hwfs.sc.scu.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.sc.scu.dao.UserRoleChngDAO;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

/**
* 사용자의 권한을 변경하는 UserRoleChng Service Implementation
*
* @ClassName UserRoleChngServiceImpl.java
* @Description UserRoleChngServiceImpl Class
* @Modification-Information
* <pre>
*    수정일       수정자              수정내용
*  ----------   ----------   -------------------------------
*  2015.05.18    김재섭        최초생성
* </pre>
* @author FC종합전산구축 : COM 김재섭
* @since 2015.05.18
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
*/
@Service("/sc/scu/userRoleChngService")
public class UserRoleChngServiceImpl extends DefaultServiceImpl implements UserRoleChngService {

    /** LogService */
    //private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** UserRoleChngDAO Bean 생성 */
    @Resource(name = "/sc/scu/userRoleChngDAO")
    private UserRoleChngDAO userRoleChngDAO;

    @Resource(name = "sccRoleChgSeqGenSequence")
    private SequenceIdGenService sccRoleChgSeqGenSequence;

    /**
     * 사용자 권한 목록을 조회한다.
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
        return userRoleChngDAO.selectList(mapParam);
    }

    /**
     * 사용자 권한 DataSetMap의 데이터를 rowType에 따라 Insert/Update/Delete 처리한다.
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
    public Long saveList(DataSetMap list) throws Exception {
        Long insRowCnt = 0L;

        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> rowData = list.get(i);
            //Insert 처리
            insRowCnt = Long.parseLong(sccRoleChgSeqGenSequence.getNextStringId().trim());
            rowData.put("chgSrlNum", insRowCnt);
            userRoleChngDAO.insert(rowData);
        }

        return insRowCnt;
    }

    /**
     * 시스템 권한변경 요청 그룹웨어 상신 Master를 조회한다.
     * <pre>
     * 메소드 상세설명 작성(생략 가능)
     * </pre>
     *
     * @param parameter
     * @return
     * @throws Exception
     * @see com.hwfs.ls.ltm.service.TestResultInqueryService#selectTestDiaryMethodList(java.util.Map)
    */
    @Override
    public Record selectGwDraftMst(Map<String, Object> parameter) throws Exception {
        return userRoleChngDAO.selectGwDraftMst(parameter);
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
        return userRoleChngDAO.saveGwInstanceId(parameter);
    }
}
