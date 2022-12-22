package com.hwfs.sc.cmn.sap;

/**
 * DB Table로 EAI 통신을 위한 Interface
 *
 * @ClassName EAITable.java
 * @Description EAITable Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 22.   김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015. 4. 22.
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EAITable {
	/**
	 * Interfacer ID를 가져온다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	String getInterfaceId();

	/**
	 * 기존 자료를 삭제하기 위한 쿼리 아이디를 가져온다. ""이면 처리하지 않는다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	String getDeleteQueryId();

	/**
	 * 쿼리 아이디를 가져온다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	String getQueryId();

	/**
	 * 처리하고자 하는 자료를 조회하여 반환한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @return
	 */
	Object getData();

	/**
	 * 처리할 자료를 추출하기 위한 Parameter을 설정한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 */
	void setParameter(Object parameter);

	void addParameter(String key, Object value);
}
