To run work with spark :

	- Run "sbt package" command in spark folder (Otherwise SQL will not compile in intelliJ alone)

		- If missing some memory to exec, use command :
	
			set SBT_OPTS= -Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Xss2M  -Duser.timezone=GMT

		Then rerun		

	- Import project in IntelliJ (using maven)

To run version of code saved in SavedCode :

	- Change file which are in .\spark\mllib\src\main\scala\org\apache\spark\mllib\fpm\ ...

	- For test, if present, change file in:
	
		.\spark\mllib\src\test\scala\org\apache\spark\mllib\fpm\PrefixSpanSuite.scala

		/!\ Version containing minPatternLength relies on the test file saved there /!\

File modified (that I shouldn't forget to push) :

	- POM.xml of mlib

	- MyPrefixSpanTest.scala in MLlib test => to remove