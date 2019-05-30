@set target_folder=d:/devl/prod_site
@echo.
@echo.
@echo Building into the folder : %target_folder%
@echo.
@echo Cleaning 
@echo.
@echo Building 
@echo.
@hugo --cleanDestinationDir --destination %target_folder% --environment PROD --gc --minify
@echo.
@echo.
@echo.
@pause