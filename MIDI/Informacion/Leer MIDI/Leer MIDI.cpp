#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>


int main(int argc, char** argv)
{
	if(argc!=2)
	{
		printf("Uso: ./prueba <archivo_midi>\n");
		return 1;
	}

	int fd = open(argv[1], O_RDONLY);
	unsigned char buffer[1];

	while(read(fd, buffer, 1))
	{
		static int i=0;
		printf("%x",buffer[0]);
		i++;
		if(i==4)
		{
			//printf("\n");
			i=0;
		}
	}

	return 0;
}
