package com.hwfs.ft.fsi.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.ft.fsi.dao.ContrtDAO;

 /**
 * 거래처 조회하는 Wh Service Implementation
 *
 * @ClassName SalsplceServiceImpl.java
 * @Description SalsplceServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.27    kjj        최초생성
 * </pre>
 * @author FC종합전산구축 : 식재도매 kjj
 * @since 2015.03.27
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/ft/fsi/contrtService")
public class ContrtServiceImpl extends DefaultServiceImpl implements ContrtService {

    /** WhDAO Bean 생성 */
    @Resource(name = "/ft/fsi/contrtDAO")
    private ContrtDAO contrtDAO;


    /**
     * 매출처 조회 목록을 조회한다.
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
        return contrtDAO.selectList(mapParam);
    }

}
