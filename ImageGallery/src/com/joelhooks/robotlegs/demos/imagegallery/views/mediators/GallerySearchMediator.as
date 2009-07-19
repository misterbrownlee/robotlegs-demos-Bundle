package com.joelhooks.robotlegs.demos.imagegallery.views.mediators
{
	import com.joelhooks.robotlegs.demos.imagegallery.remote.services.IGalleryImageService;
	import com.joelhooks.robotlegs.demos.imagegallery.views.components.GallerySearch;
	import com.joelhooks.robotlegs.demos.imagegallery.views.events.GallerySearchEvent;
	
	import org.robotlegs.core.IMediator;
	import org.robotlegs.mvcs.FlexMediator;

	public class GallerySearchMediator extends FlexMediator implements IMediator
	{
		[Inject]
		public var gallerySearch:GallerySearch;

		[Inject]
		public var imageService:IGalleryImageService;
				
		public function GallerySearchMediator()
		{
		}
		
		override public function onRegisterComplete():void
		{
			this.gallerySearch.addEventListener( GallerySearchEvent.SEARCH, handleSearch);
		}
		
		protected function handleSearch(event:GallerySearchEvent):void
		{
			imageService.search(event.searchTerm);
			dispatch( event );
		}
	}
}