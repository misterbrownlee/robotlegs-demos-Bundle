/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package org.robotlegs.demos.flashgooglemaps.model.proxies
{
	import org.robotlegs.mvcs.Proxy;
	import org.robotlegs.demos.flashgooglemaps.model.events.AssetLoaderProxyEvent;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	/**
	 * Proxy to load the xml content.
	 *  
	 * @author Peter Lorent peter.lorent@gmail.com
	 * 
	 */	
	public class AssetLoaderProxy extends Proxy
	{
		//--------------------------------------------------------------------------
		//
		//  Instance Properties
		//
		//--------------------------------------------------------------------------
		private var _urlLoader:URLLoader;
		
		//--------------------------------------------------------------------------
		//
		//  Initialization
		//
		//--------------------------------------------------------------------------
		/**
		 * Nah, no comment. 
		 * 
		 */		
		public function AssetLoaderProxy()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  API
		//
		//--------------------------------------------------------------------------
		/**
		 * No comment.
		 *  
		 * @param url String
		 * 
		 */		
		public function loadXMLContent(url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onXMLContentLoaded);
			_urlLoader.load(urlRequest);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Eventhandling
		//
		//--------------------------------------------------------------------------
		/**
		 * Event handler. Dispatches an AssetLoaderProxyEvent so the ContentMediator
		 * can pass the data to its view component.
		 *  
		 * @param event Event
		 * 
		 */		
		private function onXMLContentLoaded(event:Event):void 
		{
			var data:XML = new XML(_urlLoader.data);
			
			dispatchEvent(new AssetLoaderProxyEvent(AssetLoaderProxyEvent.XML_CONTENT_LOADED, data));
			
			_urlLoader.removeEventListener(Event.COMPLETE, onXMLContentLoaded);
			_urlLoader = null;
		}
	}
}