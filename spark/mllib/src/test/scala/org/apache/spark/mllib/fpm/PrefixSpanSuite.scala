Yo john, Si tu écris quelque chose, fais le en bleu pour être sur que je le vois  :) 

Si j’ai une petite question ou je pense que tu pourrais m’aider, je la mettrai en vert. Dit moi si tu vois une sol :)

CODE (for end of february) :

Re implement minPatternLength and MaxPatternLength more efficiently => DONE

Max itemSet size in answer + calculate it from input
Lazy computation makes computing itemSetSize expensive, since we must force early collect(). Find work around or may not be as good as expected.
Lazy collect is better here, since it makes passing the problem between computer nearly free.
Possible sol :
Calculate with freqIndexFinder (but get result before clean) 
Calculate for each local Exec (but Benefit only available in local exec ...)

Switch to local exec after X subproblem are created


LastPost array
Should be implemented in postFix class for max efficiency

FirstPos array
Should be implemented in postFix class for max efficiency

Remove empty item by passing found items => DONE (+ as optionnal param, can switch to default comportement anytime if needed)
Is there a way to estimate projected DataBase size without looking at all the sequences ? If there is I could improve my code, by switching some directly found item to local exec.
Current implem may be faster for small datasets, should be faster otherwise

Implement every PPIC options (Regex, ...) (This can be done in march if necessary)

(If time) Implement CP version of multi item

TESTS (for end of March) :

	/!\ Must be done on cloud, so that data transfer time are taken into account /!\

Test performance of standalone improvements
Test combined performance
Test performance with multiple number of submachines

PAPER (for 20 april finished) :

Think about the paper’s structure

