import sys


try:
			for line in sys.stdin:
				#web_name = line.replace("#", "_")
				print(line.replace("#", "_"))
except:
		## should only happen if input format is not correct
		logging.basicConfig(level=logging.DEBUG, filename=strftime("/tmp/parse.py_%Y%m%d-%H%M%S.log"))
		logging.exception("Oops:") 
		raise
		sys.exit(1)