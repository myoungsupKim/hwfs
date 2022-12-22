package com.hwfs.sc.cmn.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.sc.cmn.dto.AttachFileDTO;

/**
 * 첨부파일을 공통 파일 테이블에 등록 관리하는 DAO
 * - 파일은 SCC_APPEND_FILE에서 파일 저장위치를 관리
 *
 * @ClassName AttachFileDAO.java
 * @Description AttachFileDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014.12. 08.   kksoo        최초생성
 * </pre>
* @author FC종합전산구축 : AA kksoo
* @since 2014.12.08.
* @version 1.0
* @see
* <pre>
*  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
* </pre>
 */
@Repository("/sc/cmn/attachFileDAO")
public class AttachFileDAO extends DefaultDAO {

    /**
     * 첨부파일을 등록한다.
     *
     * @param map
     *            - 등록할 정보가 담긴 Map
     * @return int 등록 결과 (건수)
     * @exception Exception
     */
    public int insert(Map<String, Object> map) throws Exception {
        return update("sc.cmn.attachFileDAO.insert", map);
    }

    /**
     * 첨부파일을 수정한다.
     *
     * @param map
     *            - 수정할 정보가 담긴 Map
     * @return int 1=성공, 0=실패
     * @exception Exception
     */
    public int update(Map<String, Object> map) throws Exception {
        return update("sc.cmn.attachFileDAO.update", map);
    }

    /**
     * 첨부파일을 삭제한다.
     *
     * @param vo
     *            - 삭제할 정보가 담긴 Map
     * @return int 삭제건수
     * @exception Exception
     */
    public int delete(Map<String, Object> map) throws Exception {
        return update("sc.cmn.attachFileDAO.delete", map);
    }

    /**
     * 첨부파일 정보를 조회한다.
     *
     * @param strRefSeq
     *            - 첨부파일 참조일련번호
     * @param lngAppendSeq
     *            - 첨부일련번호
     * @return 첨부파일정보 DTO
     * @exception Exception
     */
    @SuppressWarnings("unchecked")
    public AttachFileDTO selectFileInfo(String strRefSeq, long lngAppendSeq) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("refSeq", strRefSeq);
        map.put("appendSeq", lngAppendSeq);
        List<AttachFileDTO> list;
        list = (List<AttachFileDTO>) queryForList("sc.cmn.attachFileDAO.selectFileInfo", map, AttachFileDTO.class);

        if (list == null || list.size() < 1)
            return null;
        else
            return list.get(0);
    }

    /**
     * 첨부파일 목록을 조회한다.
     *
     * @param strRefSeq
     *            - 첨부파일 참조일련번호
     * @return 첨부파일 목록
     * @exception Exception
     */
    @SuppressWarnings({ "rawtypes" })
    public List<Map> selectList(String strRefSeq) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("refSeq", strRefSeq);
        return (List<Map>) queryForList("sc.cmn.attachFileDAO.selectList", map);
    }

}
