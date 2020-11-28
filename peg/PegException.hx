package peg;

import haxe.PosInfos;
#if (haxe >= version('4.1.0-rc.1'))
class PegException extends haxe.Exception {}
#else
class PegException {
	public var message(default,null):String;

	public function new(msg:String) {
		this.message = msg;
	}

	public function toString():String {
		return this.message;
	}
}
#end

/**
 * Failures on running php interpreter.
 */
class PhpException extends PegException {}

class ParserException extends PegException {}

class UnexpectedTokenException extends ParserException {
	public final token:Token;

	public function new(token:Token, ?expected:TokenType, ?pos:PosInfos) {
		this.token = token;
		var expectedStr = expected == null ? '' : '; expected $expected';
		var pos = pos.sure();
		super('${pos.className}.${pos.methodName}: Unexpected token ${token.toString()} at line ${token.line}' + expectedStr);
	}
}