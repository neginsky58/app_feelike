define([
                'jquery', 
                'backbone',
                'underscore', 
                'Backoffice',
                'text!/templates/common/menu.html',
                'text!/templates/backend/categories/categoriesControl.html',
                'text!/templates/backend/categories/list/itemCategory.html',
                'text!/templates/backend/categories/list/emptyItemsCategories.html',
                'text!/templates/backend/categories/list/categoryTableForm.html'], 
function($, Backbone, _,  BackofficeObject,menuView,templateMain,categoryItemView,emptyCategoryView,categoryTableFormView){
        var View = Backbone.View.extend({
                el: '#main',
                initialize: function(){
                        /*this.model = new model({
                                message: 'Hello World'
                        });*/
                        //this.template = _.template( template, { model: this.model.toJSON() } );
                },
                PageRender: function(selectPage){
                        BackofficeObject.Instance.Render(menuView,templateMain,{SelectPage: selectPage,
                                Templates: {
                                        CategoryItemView: categoryItemView,
                                        CategoryTableFormView: categoryTableFormView,
                                        EmptyCategoryView: emptyCategoryView
                                }},BackofficeViewType.Categories);
                }
        });
        
        return new View();
});
