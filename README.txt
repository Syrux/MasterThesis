To run work with spark :

	- Run "sbt package" command in spark folder (Otherwise SQL will not compile in intelliJ alone)

		- If missing some memory to exec, use command :
	
			set SBT_OPTS= -Xmx2G -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=2G -Xss2M  -Duser.timezone=GMT

		Then rerun		

	- Import project in IntelliJ (using maven)

File modified (that I shouldn't forget to push) :

	- POM.xml of mlib

	- MyPrefixSpanTest.scala in MLlib test => to remove