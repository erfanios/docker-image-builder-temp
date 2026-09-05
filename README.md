# docker-image-builder-temp


## How to Build
	./docker-build-and-push.sh <your-dockerhub-username> <image-name>

# Needs, github action secrets and vars
- ${{ vars.DOCKERHUB_USERNAME }}
- ${{ secrets.DOCKERHUB_TOKEN }}
- ${{ vars.DOCKERHUB_REPO }}
