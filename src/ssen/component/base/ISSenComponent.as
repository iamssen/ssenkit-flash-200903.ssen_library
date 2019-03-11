package ssen.component.base 
{
	/**
	 * Component 가 기본적으로 갖춰야 할 Interface
	 * @author SSen
	 */
	public interface ISSenComponent 
	{
		/** 활성화 상태 */
		function get enable() : Boolean;
		function set enable(enable : Boolean) : void;
		/** 사용된 리소스들을 모두 제거한다 */
		function resourceKill() : void;
	}
}
