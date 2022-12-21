package com.hwfs.ms.mmb.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 공지사항하는 MessageBoard DAO
 * 
 * @ClassName MessageBoardDAO.java
 * @Description MessageBoardDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.27   	강대성        최초생성
 * </pre>
 * @author FC종합전산구축 : 현장지원_모바일 강대성
 * @since 2015.04.27
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/ms/mmb/messageBoardDAO")
public class MessageBoardDAO extends DefaultDAO {
	
	/**
	 * 공지사항조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mmb.messageBoardDAO.selectList", mapParam);
	}	
	
	/**
	 * 공지사항조회 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mmb.messageBoardDAO.selectList2", mapParam);
	}
	
	/**
	 * 게시간 관리자 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBoardMstList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("ms.mmb.messageBoardDAO.selectBoardMstList", mapParam);
	}
	
	/**
	 * 공지사항 조회건수를 갱신한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateReadCnt(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.messageBoardDAO.updateReadCnt", mapParam);
	}
	
	/**
	 * SCC BBS 조회 사용자를 갱신한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateUserReadYn(Map<String, Object> mapParam) throws Exception {
		return super.update("ms.mmb.messageBoardDAO.updateUserReadYn", mapParam);
	}
	
}
