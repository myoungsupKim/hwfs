package com.hwfs.sc.cmn.service;

 /**
 * jms queue에서 Message를 Read한다.
 * <pre>
 * - nonblocking (async) 방식의 read를 지원한다. 
 * <pre>
 * @ClassName AsyncMessageReader.java
 * @Description AsyncMessageReader Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2014. 12. 3.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2014. 12. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface AsyncMessageReader {

	/**
	 * Message를 Read한다.
	 * <pre>
	 * - nonblocking (async) 방식의 read이다.
	 * - 업무별로 구현해야 한다.
	 * </pre>
	 *
	 * @param readMsg
	 * @see com.hwfs.sc.cmn.service.AsyncMessageReader#readMessage(java.lang.Object)
	 */
	public void readMessage (Object readMsg);
}
