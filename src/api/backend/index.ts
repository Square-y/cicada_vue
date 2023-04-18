import createAxios from '/@/utils/axios'


const controllerUrl = '/admin/index/'
export function login(method: 'get' | 'post', params: object = {}): ApiPromise {
    return createAxios({
        url: controllerUrl + 'login',
        data: params,
        method: method,
    }) as ApiPromise
}